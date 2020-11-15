using Microsoft.Extensions.Configuration;
using Npgsql;
using System;
using System.Data;

namespace AIBackend
{
    public class ConnectionHandler : IDbConnection
    {
        public string Padrao { get; set; }
        private readonly IConfiguration configuration;

        public ConnectionHandler(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        NpgsqlConnection connection;

        string IDbConnection.ConnectionString { get; set; }

        int IDbConnection.ConnectionTimeout => 80000;

        string IDbConnection.Database => string.Empty;

        ConnectionState IDbConnection.State => connection.State;

        IDbTransaction IDbConnection.BeginTransaction()
        {
            throw new NotImplementedException();
        }

        IDbTransaction IDbConnection.BeginTransaction(IsolationLevel il)
        {
            throw new NotImplementedException();
        }

        void IDbConnection.ChangeDatabase(string databaseName)
        {
            throw new NotImplementedException();
        }

        void IDbConnection.Close()
        {
            throw new NotImplementedException();
        }

        IDbCommand IDbConnection.CreateCommand()
        {
            throw new NotImplementedException();
        }

        void IDisposable.Dispose()
        {
            if (connection != null)
                if (connection.State == ConnectionState.Open)
                    connection.Close();
        }

        void IDbConnection.Open()
        {
            connection.Open();
        }

        public NpgsqlConnection Create()
        {
            Padrao = configuration.GetConnectionString("AI");

            try
            {
                connection = new NpgsqlConnection(Padrao);
                connection.Open();
            }
            catch (Exception)
            {
                throw;
            }

            return connection;
        }
    }
}
