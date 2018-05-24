#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#include "symbol.h"

/** @file symbol.c
 *  @brief You will modify this file and implement the symbol.h interface
 *  @details Your implementation of the functions defined in symbol.h.
 *  You may add other functions if you find it helpful. Added functions
 *  should be declared <b>static</b> to indicate they are only used
 *  within this file.
 * <p>
 * @author Lingyang Zhu
 */

/** size of LC3 memory */
#define LC3_MEMORY_SIZE  (1 << 16)

/** Provide prototype for strdup() */
char *strdup(const char *s);

/** defines data structure used to store nodes in hash table */
typedef struct node {
  struct node* next;     /**< linked list of symbols at same index */
  int          hash;     /**< hash value - makes searching faster  */
  symbol_t     symbol;   /**< the data the user is interested in   */
} node_t;

/** defines the data structure for the hash table */
struct sym_table {
  int      size;        /**< size of hash table         */
  node_t** hash_table;  /**< array of linked list heads */
  char**   addr_table;  /**< look up symbols by addr    */
};

/** djb hash - found at http://www.cse.yorku.ca/~oz/hash.html
 * tolower() call to make case insensitive.
 */

static int symbol_hash (const char* name) {
  unsigned char* str  = (unsigned char*) name;
  unsigned long  hash = 5381;
  int c;

  while ((c = *str++))
    hash = ((hash << 5) + hash) + tolower(c); /* hash * 33 + c */

  c = hash & 0x7FFFFFFF; /* keep 31 bits - avoid negative values */

  return c;
}

/** @todo implement this function */
sym_table_t* symbol_init (int table_size) {
    sym_table_t *tablePointer = malloc(sizeof(sym_table_t));
    tablePointer->hash_table = calloc(table_size, sizeof(node_t));
    tablePointer->addr_table = calloc(LC3_MEMORY_SIZE, sizeof(char));
    tablePointer->size = table_size;
    return tablePointer;
}

/** @todo implement this function */
void symbol_add_unique (sym_table_t* symTab, const char* name, int addr) {
    
    
    char *myName = strdup(name);
        
    //Create new symbol
    symbol_t *s = malloc(sizeof(symbol_t));
    s->name = myName;
    s->addr = addr;
    
    //Create new node
    node_t *n = malloc(sizeof(node_t));
    
    n->hash = symbol_hash(myName);
    
    //Calculate hash table index
    int index = n->hash % symTab->size;
    
    n->next = symTab->hash_table[index];
    n->symbol = *s;
    
    
    
    //Add node
    symTab->hash_table[index] = n;
    
    if (symTab->addr_table[addr]==NULL)
        symTab->addr_table[addr] = myName;
    
    free(s);
    
}

/** @todo implement this function */
char* symbol_find_by_addr (sym_table_t* symTab, int addr) {
    char *symbolName = symTab->addr_table[addr];    
    return symbolName;
}

/** @todo implement this function */
void symbol_iterate (sym_table_t* symTab, iterate_fnc_t fnc, void* data) {
    for (int i = 0; i<symTab->size; i++)
    {
        node_t *temp = symTab->hash_table[i];
        
        while (temp!=NULL)
        {
            symbol_t *mySymbol = &temp->symbol;
            (*fnc)(mySymbol, data);
            temp = temp->next;
        }
    }
}

/** @todo implement this function */
struct node* symbol_search (sym_table_t* symTab, const char* name, int* hash, int* index) {
    char *myName = strdup(name);
    *hash = symbol_hash(myName);
    *index = *hash%symTab->size;
    
    node_t* myNode = NULL;
    
    for (int i = 0; i<symTab->size; i++)
    {
        node_t *temp = symTab->hash_table[i];
        
        while (temp!=NULL)
        {
            if (temp->hash == *hash){
                if (strcasecmp(myName, temp->symbol.name)==0){
                    myNode = temp;
                    break;
                }
            }
            temp = temp->next;
        }
    }
    free(myName);
  
  return myNode;
}

/** @todo implement this function */
int symbol_add (sym_table_t* symTab, const char* name, int addr) {
    int hash = 0;
    int index = 0;
    if (symbol_search(symTab, name, &hash, &index)!=NULL){
        return 0;
    }
    symbol_add_unique(symTab, name, addr);
    return 1;
}

/** @todo implement this function */
symbol_t* symbol_find_by_name (sym_table_t* symTab, const char* name) {
    int hash = 0;
    int index = 0;
    if (symbol_search(symTab, name, &hash, &index)!=NULL){
        node_t *n = symbol_search(symTab, name, &hash, &index);
        symbol_t r = n->symbol;
        symbol_t *result = &r;
        return result;
    }
    else
        return NULL;
}

/** @todo implement this function */
void symbol_reset(sym_table_t* symTab) {
    
    for (int i = 0; i<symTab->size; i++){
        
        node_t *temp = symTab->hash_table[i];
        
        while (temp!=NULL){
            
            //Get symbol of the node
            int index = temp->hash % symTab->size;
            symTab->addr_table[index] = NULL;
            
            //Free the name in the symbol of the current node
            free(temp->symbol.name);
            //free(temp->symbol);
            
            node_t *n = temp;
            temp = temp->next;
            
            //Free the node
            free(n);
            
        }
        
    }
//     for (int j = 0; j<LC3_MEMORY_SIZE; j++){
//         symTab->addr_table[j] = NULL;
//     }
    
}


/** @todo implement this function */
void symbol_term (sym_table_t* symTab) {
    symbol_reset(symTab);
    free(symTab->hash_table);
    free(symTab->addr_table);
    free(symTab);
}





































