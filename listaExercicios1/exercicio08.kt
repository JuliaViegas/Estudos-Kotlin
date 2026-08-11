fun matricular(nome: String, curso: String = "ADS", periodo: Int = 1) {
 println("$nome — $curso — ${periodo}º período")
}

fun main(){
    matricular(nome = "Maria")
    matricular(nome = "Larissa", curso = "CC", periodo = 2)
    matricular(curso = "ADS", nome = "Ana", periodo = 1)
}

//Saída no console:
Maria — ADS — 1º período
Larissa — CC — 2º período
Ana — ADS — 1º período