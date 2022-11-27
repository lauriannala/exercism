import java.time.LocalDate
import java.time.LocalDateTime

fun Gigasecond(dateTime: LocalDate) = Gigasecond(dateTime.atStartOfDay())
class Gigasecond(date: LocalDateTime) {
    val date: LocalDateTime = date.plusSeconds(1_000_000_000)
}
