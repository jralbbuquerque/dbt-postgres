import psycopg2
import pandas as pd
import logging
import os

# Create logging object
logging.basicConfig(
    format='%(asctime)s - %(levelname)s - %(message)s', 
    level=logging.INFO
)

# Get path home of project
PATH_HOME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def create_connection():
    logging.info("Creating Database Connection...")

    conn = psycopg2.connect(
        database = os.getenv('POSTGRES_DB'),
        user     = os.getenv('POSTGRES_USER'),
        password = os.getenv('POSTGRES_PASSWORD'),
        host     = os.getenv('POSTGRES_HOST'),
        port     = os.getenv('POSTGRES_PORT')
    )

    cursor = conn.cursor()

    logging.info("Connection to Database stablished")

    return conn, cursor

if __name__ == '__main__':
    # Create connection and cursor
    conn, cursor = create_connection()
    
    logging.info("Creating objects...")

    # Get file with create objects queries
    with open(f"{PATH_HOME}/scripts/sql/create_objects.sql", "r") as f:
        query = f.read()

    # Create database objects
    cursor.execute(query)
    # Commit transaction
    conn.commit()
    cursor.close()
    conn.close()

    logging.info("Tables created")

    # Get csv filename and link with related table
    schema = os.getenv('POSTGRES_SRC_SCHEMA')
    dict_files = {
        "categories.csv": f"{schema}.categories",
        "customers.csv": f"{schema}.customers",
        "employees.csv": f"{schema}.employees",
        "orderdetails.csv": f"{schema}.order_details",
        "orders.csv": f"{schema}.orders",
        "products.csv": f"{schema}.products",
        "shippers.csv": f"{schema}.shippers",
        "suppliers.csv": f"{schema}.suppliers"
    }

    # To each file
    for file in dict_files.keys():
        # Get tablename
        tablename = dict_files[file]

        # Load csv data into pandas dataframe
        data = pd.read_csv(f"{PATH_HOME}/database/datasrc/{file}", sep=';')
        data = data.where(pd.notnull(data), None)
        
        try:
            logging.info(f"Loading {len(data)} records to the table {tablename}...")
                    
            # Create connection and cursor
            conn, cursor = create_connection()

            # Get values from database and save into a variable
            data_values = b",".join(
                cursor.mogrify("(" + "%s," * (len(data.columns) - 1) + "%s)", x)
                for x in tuple(map(tuple, data.values))
            )
            
            # Run insert values
            cursor.execute(f"INSERT INTO {tablename} VALUES {data_values.decode('utf-8')}")

            logging.info(f"{tablename} uploaded to the Database")

            # Commit transaction
            conn.commit()
            cursor.close()
            conn.close()

        except Exception as e:
            logging.error(f"{tablename}: {e}")

    logging.info('Process finished')