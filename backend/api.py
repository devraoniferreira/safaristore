from flask import Flask, jsonify
from flask_cors import CORS
from db_connection import DatabaseConnection

# Configurações do Banco de Dados
DB_PATH = r'C:\scl\dados\Elbrus.IB'
DB_PATH2 = r'C:\SCL\dados\ELBRUS.IB'
USER = 'sysdba'
PASSWORD = 'masterkey'

app = Flask(__name__)

# Inicializa a CORS para permitir requisições de diferentes origens
CORS(app)

# Inicializa a conexão com o banco de dados
db_connection = DatabaseConnection(DB_PATH, DB_PATH2, USER, PASSWORD)
db_connection.connect()

@app.route('/get_records', methods=['GET'])
def get_records():
    records = db_connection.get_records()
    return jsonify(records)  # Retorna os registros em formato JSON

if __name__ == '__main__':
    # Inicia o servidor Flask na porta 5000
    app.run(debug=True, host='0.0.0.0', port=5000)
