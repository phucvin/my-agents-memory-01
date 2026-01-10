#ifndef PARSER_H
#define PARSER_H

#include "ir.h"
#include <string>

namespace parser {

ir::Function Parse(const std::string& input);

}

#endif
