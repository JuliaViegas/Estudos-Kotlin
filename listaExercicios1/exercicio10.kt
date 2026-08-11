fun botao(rotulo: String, onClick: ()->Unit) {
 println("[$rotulo] clicado")
 onClick()
}

fun main() {
    botao("Salvar") { println("Salvo!") }
}