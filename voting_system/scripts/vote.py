#!/usr/bin/python3

from brownie import Vote, accounts


def main():
    return Vote.deploy({'from': accounts[0]})