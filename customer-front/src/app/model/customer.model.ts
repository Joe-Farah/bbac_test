  export interface Address {
    id: number;
    street: string;
    city: string;
    state: string;
    zipCode: string;
    country: string;
    type: string;
  }
  
  export interface CreditCard {
    id: number;
    cardNumber: string;
    cardType: string;
    cvv: string;
    expiryDate: string;
    creditLimit: number;
    availableBalance: number;
  }
  
  export interface Customer {
    id: number;
    firstName: string;
    lastName: string;
    email: string;
    phone: string;
    dateOfBirth: string;
    addresses: Address[];
    creditCards: CreditCard[];
  }
  
  