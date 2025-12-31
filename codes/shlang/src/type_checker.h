#ifndef TYPE_CHECKER_H
#define TYPE_CHECKER_H

#include "ast.h"
#include <map>
#include <string>
#include <vector>
#include <iostream>

class TypeChecker {
public:
    TypeChecker(std::shared_ptr<Program> program);
    void check();

private:
    std::shared_ptr<Program> program;
    std::map<std::string, std::shared_ptr<Type>> structDefs;
    std::map<std::string, std::shared_ptr<Type>> interfaceDefs;
    std::vector<std::map<std::string, std::shared_ptr<Type>>> scopes; // Variable types

    void enterScope();
    void exitScope();
    void define(std::string name, std::shared_ptr<Type> type);
    std::shared_ptr<Type> resolve(std::string name);

    void checkNode(std::shared_ptr<ASTNode> node);
    std::shared_ptr<Type> inferType(std::shared_ptr<ASTNode> node);

    // Helpers
    bool isAssignable(std::shared_ptr<Type> target, std::shared_ptr<Type> source);
    bool implementsInterface(std::shared_ptr<Type> structType, std::shared_ptr<Type> interfaceType);
};

#endif
