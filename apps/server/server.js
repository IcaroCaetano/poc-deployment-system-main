// Importa a aplicação Express definida no arquivo app.js
const app = require("./app");

// Define a porta do servidor
// Usa a variável de ambiente PORT, se existir, caso contrário, usa 3000
const port = process.env.PORT || 3000;

// Inicia o servidor e escuta na porta definida
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
