// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract FileStorage {
    struct File {
        string ipfsHash;
        string fileName;
        uint fileSize;
        string fileType;
        address owner;
    }

    mapping(uint => File) public files;
    uint public fileCount;

    event FileUploaded(
        uint fileId,
        string ipfsHash,
        string fileName,
        uint fileSize,
        string fileType,
        address indexed owner
    );

    function uploadFile(string memory _ipfsHash, string memory _fileName, uint _fileSize, string memory _fileType) public {
        require(bytes(_ipfsHash).length > 0, "IPFS hash is required.");
        require(bytes(_fileName).length > 0, "File Name is required.");
        require(bytes(_fileType).length > 0, "File Type is required.");
        require(_fileSize > 0, "File Size is required.");

        fileCount++;
        files[fileCount] = File({
            ipfsHash: _ipfsHash,
            fileName: _fileName,
            fileSize: _fileSize,
            fileType: _fileType,
            owner: msg.sender
        });

        emit FileUploaded(fileCount, _ipfsHash, _fileName, _fileSize, _fileType, msg.sender);
    }
}