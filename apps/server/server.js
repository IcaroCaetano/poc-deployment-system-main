// Importa a aplicação Express definida no arquivo app.js
// Import the Express application defined in the app.js file
const app = require("./app");

// Define a porta do servidor
// Usa a variável de ambiente PORT, se existir, caso contrário, usa 3001
// Set the server port
// Uses the PORT environment variable, if it exists, otherwise uses 3001
const port = process.env.PORT || 3001;

// Inicia o servidor e escuta na porta definida
// Start the server and listen on the defined port
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
