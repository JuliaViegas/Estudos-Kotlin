data class Endereco(val cidade: String?)
data class Aluno(val nome: String, val endereco: Endereco?)
fun main() {
 val ana = Aluno("Ana", null)
 val beto = Aluno("Beto", Endereco("São Paulo"))
 val caio = Aluno("Caio", Endereco(null))

 println(ana?.endereco?.cidade ?: "endereço não informado")
 println(beto?.endereco?.cidade ?: "endereço não informado")
 println(caio?.endereco?.cidade ?: "endereço não informado")
}

//Saída no console:
/*endereço não informado
São Paulo
endereço não informado*/