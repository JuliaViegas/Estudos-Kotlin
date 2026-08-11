/*fun main() {
    val disciplina = "Programação Mobile"
    val aulas = 20
    aulas = 21
    println("$disciplina tem $aulas aulas")
}*/

//o código acima gera o erro "'val' cannot be reassigned.", pois tenta alterar o valor da variável "aulas" que é do tipo "val". O tipo val é usado para delcarar referências imutáveis, assim como o "final String" em Java.
//Pensei em duas formas de corrigir o código:
fun main(){

    //correção 1:
    val disciplina1 = "Programação Mobile"
    val aulas1 = 20
    println("$disciplina1 tem $aulas1 aulas")

    //correção 2:
    val disciplina2 = "Programação Mobile"
    var aulas2 = 20
    aulas2 = 21
    println("$disciplina2 tem $aulas2 aulas")
}
