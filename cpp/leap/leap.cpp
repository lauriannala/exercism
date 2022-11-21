#include "leap.h"

namespace leap {
    bool is_leap_year(int i) {
        if (i % 400 == 0) return true;
        if (i % 100 == 0) return false;
        if (i % 4 == 0) return true;

        return false;
    }
}  // namespace leap
