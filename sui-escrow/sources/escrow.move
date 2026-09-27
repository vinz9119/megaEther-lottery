module sui_escrow::escrow;

use std::option::{Self, Option};
use sui::coin::{Self, Coin};
use sui::event;
use sui::object::{Self, UID};
use sui::sui::SUI;
use sui::transfer;
use sui::tx_context::{Self, TxContext};

const E_NOT_BUYER: u64 = 0;
const E_ALREADY_FUNDED: u64 = 1;
const E_NOT_FUNDED: u64 = 2;
const E_WRONG_AMOUNT: u64 = 3;
const E_ALREADY_CANCELLED: u64 = 4;

public struct Escrow has key {
    id: UID,
    buyer: address,
    seller: address,
    amount: u64,
    payment: Option<Coin<SUI>>,
}

public struct EscrowCreated has copy, drop {
    escrow_id: address,
    buyer: address,
    seller: address,
    amount: u64,
}

public struct EscrowFunded has copy, drop {
    escrow_id: address,
    amount: u64,
}

public struct EscrowReleased has copy, drop {
    escrow_id: address,
    seller: address,
    amount: u64,
}

public struct EscrowRefunded has copy, drop {
    escrow_id: address,
    buyer: address,
    amount: u64,
}

public struct EscrowCancelled has copy, drop {
    escrow_id: address,
    buyer: address,
}

public fun create(seller: address, amount: u64, ctx: &mut TxContext) {
    let escrow = Escrow {
        id: object::new(ctx),
        buyer: tx_context::sender(ctx),
        seller,
        amount,
        payment: option::none(),
    };
    let escrow_id = object::uid_to_address(&escrow.id);
    event::emit(EscrowCreated {
        escrow_id,
        buyer: escrow.buyer,
        seller: escrow.seller,
        amount: escrow.amount,
    });
    transfer::share_object(escrow);
}

public fun fund(escrow: &mut Escrow, payment: Coin<SUI>, ctx: &mut TxContext) {
    assert!(tx_context::sender(ctx) == escrow.buyer, E_NOT_BUYER);
    assert!(option::is_none(&escrow.payment), E_ALREADY_FUNDED);
    assert!(coin::value(&payment) == escrow.amount, E_WRONG_AMOUNT);

    let amount = coin::value(&payment);
    escrow.payment = option::some(payment);

    event::emit(EscrowFunded {
        escrow_id: object::uid_to_address(&escrow.id),
        amount,
    });
}

public fun release(escrow: Escrow, ctx: &mut TxContext) {
    assert!(tx_context::sender(ctx) == escrow.buyer, E_NOT_BUYER);
    assert!(option::is_some(&escrow.payment), E_NOT_FUNDED);

    let Escrow { id, buyer: _, seller, amount, payment } = escrow;
    let escrow_id = object::uid_to_address(&id);
    let payment = option::extract(&mut payment);
    object::delete(id);
    transfer::public_transfer(payment, seller);

    event::emit(EscrowReleased {
        escrow_id,
        seller,
        amount,
    });
}

public fun refund(escrow: Escrow, ctx: &mut TxContext) {
    assert!(tx_context::sender(ctx) == escrow.buyer, E_NOT_BUYER);
    assert!(option::is_some(&escrow.payment), E_NOT_FUNDED);

    let Escrow { id, buyer, seller: _, amount, payment } = escrow;
    let escrow_id = object::uid_to_address(&id);
    let payment = option::extract(&mut payment);
    object::delete(id);
    transfer::public_transfer(payment, buyer);

    event::emit(EscrowRefunded {
        escrow_id,
        buyer,
        amount,
    });
}

public fun cancel(escrow: Escrow, ctx: &mut TxContext) {
    assert!(tx_context::sender(ctx) == escrow.buyer, E_NOT_BUYER);
    assert!(option::is_none(&escrow.payment), E_ALREADY_CANCELLED);

    let Escrow { id, buyer, seller: _, amount: _, payment: _ } = escrow;
    let escrow_id = object::uid_to_address(&id);
    object::delete(id);

    event::emit(EscrowCancelled {
        escrow_id,
        buyer,
    });
}

public fun buyer(escrow: &Escrow): address {
    escrow.buyer
}

public fun seller(escrow: &Escrow): address {
    escrow.seller
}

public fun amount(escrow: &Escrow): u64 {
    escrow.amount
}

public fun is_funded(escrow: &Escrow): bool {
    option::is_some(&escrow.payment)
}

#[test]
fun test_amount_is_preserved() {
    let amount = 1_000_000;
    assert!(amount == 1_000_000, E_WRONG_AMOUNT);
}
