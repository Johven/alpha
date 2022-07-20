#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

ANGCOIND=${ANGCOIND:-$BINDIR/angcoind}
ANGCOINCLI=${ANGCOINCLI:-$BINDIR/angcoin-cli}
ANGCOINTX=${ANGCOINTX:-$BINDIR/angcoin-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/angcoin-wallet}
ANGCOINQT=${ANGCOINQT:-$BINDIR/qt/angcoin-qt}

[ ! -x $ANGCOIND ] && echo "$ANGCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a ANGVER <<< "$($ANGCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for angcoind if --version-string is not set,
# but has different outcomes for angcoin-qt and angcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$ANGCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $ANGCOIND $ANGCOINCLI $ANGCOINTX $WALLET_TOOL $ANGCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${ANGVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${ANGVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
