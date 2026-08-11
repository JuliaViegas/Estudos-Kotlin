fun main() {
 val nomes = listOf("Ana", "Beatriz", "Caio", "Daniela")
 // 1) declare a lambda emMaiusculas
 val maiusculas:  (String) -> String = {nome -> nome.uppercase()}


 // 2) versão com parâmetro nomeado
 val versao1 = nomes.filter{nome -> nome.length > 4}.map{nome -> maiusculas(nome)}
 println(versao1)

 // 3) versão com it
 val versao2 = nomes.filter{it.length > 4}.map{ maiusculas(it)}
 println(versao2)
}

//Saída no console
[BEATRIZ, DANIELA]
[BEATRIZ, DANIELA]