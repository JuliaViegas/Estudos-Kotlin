fun tamanhoSeguro(texto: String?): Int = (texto?.length ?: 0)
fun main() {
 println(tamanhoSeguro("Kotlin")) // deve imprimir 6
 println(tamanhoSeguro(null)) // deve imprimir 0

}