fun saudacao(nome: String = "Maria", prefixo: String = "Olá"): String = "$prefixo, $nome!"

fun main(){
    println(saudacao())
    println(saudacao(prefixo = "Boa noite"))
}