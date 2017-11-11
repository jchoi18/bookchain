pragma solidity ^0.4.0;

contract Textbook {
    
    struct Book {
        string isbn;
        address owner;
    }
    
    mapping (string => uint) private balance;
    mapping (string => Book) private books;
    mapping (bytes32 => bool) private books_proof;
    mapping (address => bool) private students;
    mapping (string => address) private owners;
    mapping (string => address) private holders;
    
    // store a proof of existence in the contract state
    function addBook(string isbn, address self) {
        var book = Book(isbn, self);
        books[isbn] = book;
        students[self] = true;
        owners[isbn] = self;
    }
    
    // calculate and store the proof for a document
    function notarize(string isbn) {
        addBook(isbn, msg.sender);
        books_proof[hashFor(isbn)] = true;
    }
    
    // helper function to get a document's sha256
    function hashFor(string isbn) constant returns (bytes32) {
        return sha256(isbn);
    }
    
    // check if a document has been notarized
    function isOwner(string book) constant returns (bool) {
        return books[book].owner == msg.sender;
    }

    function bookExists(string isbn) constant returns (bool) {
        bytes32 hash = hashFor(isbn);
        if (books_proof[hash]) {
            return books_proof[hash];
        }
        return false;
    }

    /*function transfer(address _to, uint256 _value) {
        require(balance[msg.sender] >= _value);           // Check if the sender has enough
        require(balance[_to] + _value >= balance[_to]); // Check for overflows
        balance[msg.sender] -= _value;                    // Subtract from the sender
        balance[_to] += _value;                           // Add the same to the recipient
    }*/
}
