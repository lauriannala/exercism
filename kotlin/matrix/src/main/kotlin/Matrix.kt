class Matrix(private val matrixAsString: String) {

    private val matrix = matrixAsString
        .split("\n")
        .map { it.split(" ").map{ str -> str.toInt() } }

    fun column(colNr: Int): List<Int> {
        return matrix.map { it -> it[colNr - 1] }
    }

    fun row(rowNr: Int): List<Int> {
        return matrix[rowNr - 1]
    }
}
