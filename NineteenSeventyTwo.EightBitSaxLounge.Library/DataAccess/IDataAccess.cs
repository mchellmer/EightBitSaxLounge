namespace NineteenSeventyTwo.EightBitSaxLounge.Library.DataAccess;

public interface IDataAccess
{
    /// <summary>
    /// Load data from a SQL database asynchronously.
    /// </summary>
    /// <typeparam name="T"> The type of data to load. </typeparam>
    /// <typeparam name="TU"> The type of parameters to pass to the stored procedure. </typeparam>
    /// <param name="storedProcedure"> The name of the stored procedure to execute. </param>
    /// <param name="parameters"> The parameters to pass to the stored procedure. </param>
    /// <param name="connectionStringName"> The name of the connection string to use. </param>
    /// <returns> A list of data of type T. </returns>
    Task<List<T>> LoadDataAsync<T, TU>(
        string storedProcedure,
        TU parameters,
        string connectionStringName);

    /// <summary>
    /// Save data to a SQL database asynchronously.
    /// </summary>
    /// <typeparam name="T"> The type of data to save. </typeparam>
    /// <param name="storedProcedure"> The name of the stored procedure to execute. </param>
    /// <param name="parameters"> The parameters to pass to the stored procedure. </param>
    /// <param name="connectionStringName"> The name of the connection string to use. </param>
    /// <returns> A task representing the asynchronous operation. </returns>
    Task SaveDataAsync<T>(
        string storedProcedure,
        T parameters,
        string connectionStringName);
}