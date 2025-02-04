using System.Data;
using Dapper;
using Microsoft.Data.SqlClient;

namespace NineteenSeventyTwo.EightBitSaxLounge.Library.DataAccess;

using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

/// <summary>
/// The SqlDataAccess class is used to interact with a SQL database.
/// </summary>
/// <inheritdoc />
public class SqlDataAccess : IDataAccess
{
    /// <summary>
    /// Interact with configuration data in e.g. appsettings.json.
    /// </summary>
    private readonly IConfiguration _config;
    
    /// <summary>
    /// Set logger for data access.
    /// </summary>
    private readonly ILogger<SqlDataAccess> _logger;

    /// <summary>
    /// Initializes a new instance of the SqlDataAccess class.
    /// </summary>
    /// <param name="config"> The configuration object. </param>
    /// <param name="logger"> The logger object. </param>
    public SqlDataAccess(
        IConfiguration config,
        ILogger<SqlDataAccess> logger)
    {
        this._config = config;
        this._logger = logger;
    }

    /// <inheritdoc />
    /// <exception cref="InvalidOperationException"></exception>
    public async Task<List<T>> LoadDataAsync<T, TU>(
        string storedProcedure,
        TU parameters,
        string connectionStringName)
    {
        string connectionString = _config.GetConnectionString(connectionStringName) 
                                  ?? throw new InvalidOperationException("Connection string not found while loading data.");

        try
        {
            using IDbConnection connection = new SqlConnection(connectionString);
        
            var rows = await connection.QueryAsync<T>(storedProcedure, parameters, commandType: CommandType.StoredProcedure);
            
            _logger.LogInformation("Data loaded from the database via stored procedure {storedProcedure}.", storedProcedure);
            
            return rows.ToList();
        }
        catch (Exception exception)
        {
            _logger.LogError(exception, 
                "Error loading data from the database. Message: {message}", 
                exception.Message);
            throw;
        }
    }
    
    /// <inheritdoc />
    public async Task SaveDataAsync<T>(
        string storedProcedure,
        T parameters,
        string connectionStringName)
    {
        string connectionString = _config.GetConnectionString(connectionStringName) 
                                  ?? throw new InvalidOperationException("Connection string not found while saving data.");

        try
        {
            using IDbConnection connection = new SqlConnection(connectionString);
        
            await connection.ExecuteAsync(
                storedProcedure, 
                parameters, 
                commandType: CommandType.StoredProcedure);
            
            _logger.LogInformation("Data saved to the database via stored procedure {storedProcedure}.", storedProcedure);
        }
        catch (Exception exception)
        {
            _logger.LogError(
                exception, 
                "Error saving data to the database via stored procedure {storedProcedure}. Message: {message}", 
                storedProcedure, 
                exception.Message);
            throw;
        }
    }
}