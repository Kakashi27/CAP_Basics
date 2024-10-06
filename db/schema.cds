namespace learning.Anil;

using {
    cuid,
    managed,
    Currency,
    Country,
    sap.common.CodeList
} from '@sap/cds/common';

entity Books : cuid, managed {
    title       : String(255) @mandatory;
    author      : Association to Authors @mandatory @assert.target;
    genre       : Genre @assert.range: true;
    publCountry : Country;
    stock       : NoOfBooks default 0;
    price       : Price;
    isHardCover : Boolean;
}

type Genre     : Integer enum {
    fiction     = 1;
    non_fiction = 2;
}

type NoOfBooks : Integer;

type Price     : {
    amount   : Integer;
    currency : Currency;
};

entity Authors : cuid, managed {
    name        : String(100) @mandatory;
    dateOfBirth : Date;
    dateOfDeath : Date;
    epoch       : Association to Epochs @assert.target;
    books       : Association to many Books
                      on books.author = $self;
}

entity Epochs : CodeList {
    key ID : Integer;
}

annotate Books with {
    modifiedAt @odata.etag
};

annotate Authors with {
    modifiedAt @odata.etag
};


