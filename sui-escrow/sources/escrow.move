module sui_escrow::escrow;

use std::option::{Self, Option};
use sui::coin::{Self, Coin};
use sui::object::{Self, UID};
use sui::sui::SUI;
use sui::transfer;
use sui::tx_context::{Self, TxContext};

const E_NOT_BUYER: u64 = 0;
const E_NOT_SELLER: u64 = 1;
const E_ALREADY_FUNDED: u64 = 2;
const E_NOT_FUNDED: u64 = 3;
const E_WRONG_AMOUNT: u64 = 4;

public struct Escrow has key {
    id: UID,
    buyer: address,
    seller: address,
    amount: u64,
    payment: Option<Coin<SUI>>,
}

public fun create(seller: address, amount: u64, ctx: &mut TxContext) {
    let escrow = Escrow {
        id: object::new(ctx),
        buyer: tx_context::sender(ctx),
        seller,
        amount,
        payment: option::none(),
    };
    transfer::share_object(escrow);
}

public fun fund(escrow: &mut Escrow, payment: Coin<SUI>, ctx: &mut TxContext) {
    assert!(tx_context::sender(ctx) == escrow.buyer, E_NOT_BUYER);
    assert!(option::is_none(&escrow.payment), E_ALREADY_FUNDED);
    assert!(coin::value(&payment) == escrow.amount, E_WRONG_AMOUNT);
    escrow.payment = option::some(payment);
}

public fun release(escrow: &mut Escrow, ctx: &mut TxContext) {
    assert!(tx_context::sender(ctx) == escrow.buyer, E_NOT_BUYER);
    assert!(option::is_some(&escrow.payment), E_NOT_FUNDED);
    let payment = option::extract(&mut escrow.payment);
    transfer::public_transfer(payment, escrow.seller);
}

public fun refund(escrow: &mut Escrow, ctx: &mut TxContext) {
    assert!(tx_context::sender(ctx) == escrow.buyer, E_NOT_BUYER);
    assert!(option::is_some(&escrow.payment), E_NOT_FUNDED);
    let payment = option::extract(&mut escrow.payment);
    transfer::public_transfer(payment, escrow.buyer);
}

public fun cancel_before_funding(escrow: Escrow, ctx: &mut TxContext) {
    assert!(tx_context::sender(ctx) == escrow.seller, E_NOT_SELLER);
    assert!(option::is_none(&escrow.payment), E_ALREADY_FUNDED);
    let Escrow { id, buyer: _, seller, amount: _, payment: _ } = escrow;
    object::delete(id);
    transfer::public_transfer(
        sui::coin::zero<SUI>(ctx),
        seller
    );
}
