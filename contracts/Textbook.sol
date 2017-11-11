pragma solidity ^0.4.0;


contract Textbook {
    struct Book {
    string isbn;
    address owner;
    address holder;
    uint id;
    }

    mapping (bytes32 => Book) private books;
    mapping (bytes32 => address) private students;
    address[] studentAddresses;

    // store a proof of existence in the contract state
    function addBook(bytes32 bookHash, address self) {
        books[bookHash] = true;
        var selfHash = sha256(self);
        if (students[selfHash] != self){
            students[selfHash] = self;
        }
    }
    // calculate and store the proof for a document
//      function notarize(Book book) {
//        var bookHash = hashFor(book);
//        addBook(bookHash);
//      }
    // helper function to get a document's sha256
    function hashFor(Book book) constant returns (bytes32) {
        var s = book.isbn + book.owner;
        return sha256(s);
    }
    // check if a document has been notarized
    function isOwner(Book book) constant returns (bool) {
        var hash = hashFor(book);
        return books[hash];
    }

    function bookExists(string isbn) constant returns (address) {
        var hash = "";
        for (uint i = 0; i < studentAddresses.length; i++) {
            hash = sha256(isbn + studentAddresses[i]);
            if (books[hash]){
                return books[hash];
            }
        }
        return 0;
    }

    function transfer(address _to, uint256 _value) {
        require(balanceOf[msg.sender] >= _value);           // Check if the sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to]); // Check for overflows
        balanceOf[msg.sender] -= _value;                    // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
    }
}
