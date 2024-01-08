create database library_managment;
use library_managment;

-- Table 1 creation and importing data using Table Data Import Wizard
create table library_branch(
library_branch_ID tinyint AUTO_INCREMENT primary key,
library_branch_BranchName varchar(50),
library_branch_BranchAddress varchar(50)
);

-- Table 2 creation and importing data using Table Data Import Wizard
create table publisher (
publisher_PublisherName varchar(50) primary key,
publisher_PublisherAddress text,
publisher_PublisherPhone varchar(30)
);

-- Table 3 creation and importing data using Table Data Import Wizard
create table books(
book_BookID tinyint AUTO_INCREMENT primary key,
book_Title text,
book_PublisherName varchar(50)
);

-- Table 4 creation and importing data using Table Data Import Wizard
create table authors (
book_authors_AuthorID tinyint AUTO_INCREMENT primary key,
book_authors_BookID tinyint ,
book_authors_AuthorName varchar(50)
);

-- Table 5 creation and importing data using Table Data Import Wizard
create table borrower (
borrower_CardNo tinyint AUTO_INCREMENT primary key,
borrower_BorrowerName varchar(50),
borrower_BorrowerAddress text,
borrower_BorrowerPhone varchar(30)
);

-- Table 6 creation and importing data using Table Data Import Wizard
create table book_lones (
book_lones_LoansID tinyint AUTO_INCREMENT primary key,
book_loans_BookID tinyint ,
book_loans_BranchID tinyint,
book_loans_CardNo tinyint,
book_loans_DateOut DATE ,
book_loans_DueDate DATE
);

-- Table 7 creation and importing data using Table Data Import Wizard
create table book_copies (
book_copiesCopiesID tinyint AUTO_INCREMENT primary key,
book_copies_BookID tinyint ,
book_copies_BranchID tinyint,
book_copies_No_Of_Copies tinyint
); 

/*
lets create Foreign Keys establishing relationship 
between all the tables and complete the scheme diagram
*/

alter table books add constraint fk_book_publisherName foreign key(book_PublisherName) references 
publisher(publisher_PublisherName) on delete cascade on update cascade;

alter table authors add constraint fk_authors foreign key(book_authors_BookID) references 
books(book_BookID) on delete cascade on update cascade;

alter table book_lones add constraint fk_book_loans foreign key(book_loans_CardNo) references 
borrower(borrower_CardNo) on delete cascade on update cascade;

alter table book_copies add constraint fk_book_copies foreign key(book_copies_BranchID) references 
library_branch(library_branch_ID) on delete cascade on update cascade;

alter table book_lones add constraint fk_book_loans1 foreign key(book_loans_BranchID) references 
library_branch(library_branch_ID) on delete cascade on update cascade;

alter table book_copies add constraint fk_book_copies1 foreign key(book_copies_BookID) references 
books(book_BookID) on delete cascade on update cascade;

alter table book_lones add constraint fk_book_loans2 foreign key(book_loans_BookID) references 
books(book_BookID) on delete cascade on update cascade;

/* Lets Solve all the 
data analysis queries */

-- 1 How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
select l.library_branch_ID, b.book_Title, book_copies_No_Of_Copies from books b inner join book_copies e
on b.book_BookID = e.book_copies_BookID 
inner join library_branch l on l.library_branch_ID = e.book_copies_BranchID 
where b.book_Title = 'The Lost Tribe' and l.library_branch_BranchName = 'Sharpstown' group by library_branch_ID, book_Title, book_copies_No_Of_Copies
;








