pragma solidity ^0.4.0;

contract Textbook {
    
    struct Book {
        string isbn;
    }
    
    mapping (bytes32 => Book) public books;
    mapping (bytes32 => bool) private books_proof;
    mapping (bytes32 => address) public owners; // map book to owners
    mapping (bytes32 => address) public holders; // map book to holders

    function getOwner(string isbn) public constant returns (address) {
        return owners[hashFor(isbn)];
    }
    function getHolder(string isbn) public constant returns (address) {
        return holders[hashFor(isbn)];
    }

    function addBookHelper(string isbn) private {
        var book = Book(isbn);
        bytes32 hash = hashFor(isbn);
        books[hash] = book;
        owners[hash] = msg.sender;
        holders[hash] = msg.sender;
    }
    
    function addBook(string isbn) public {
        addBookHelper(isbn);
        books_proof[hashFor(isbn)] = true;
    }
    
    // helper function to get a document's sha256
    function hashFor(string isbn) private pure returns (bytes32) {
        return sha256(isbn);
    }
    
    // check if a document has been notarized
    function isOwner(string isbn) public constant returns (bool) {
        return owners[hashFor(isbn)] == msg.sender;
    }

    function bookExists(string isbn) public constant returns (bool) {
        bytes32 hash = hashFor(isbn);
        if (books_proof[hash]) {
            return books_proof[hash];
        }
        return false;
    }

    function transfer(address _to, string isbn) public {
        bytes32 bookHash = hashFor(isbn);
        // check that book exists
        require(books_proof[bookHash]);
        // check that book is held by the current holder
        require(holders[bookHash] == msg.sender);
        // update book holder
        holders[bookHash] = _to;
    }
}
