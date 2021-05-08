#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

AFCOD=${AFCOD:-$BINDIR/afcod}
AFCOCLI=${AFCOCLI:-$BINDIR/afco-cli}
AFCOTX=${AFCOTX:-$BINDIR/afco-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/afco-wallet}
AFCOQT=${AFCOQT:-$BINDIR/qt/afco-qt}

[ ! -x $AFCOD ] && echo "$AFCOD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a AFCOVER <<< "$($AFCOCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for afcod if --version-string is not set,
# but has different outcomes for afco-qt and afco-cli.
echo "[COPYRIGHT]" > footer.h2m
$AFCOD --version | sed -n '1!p' >> footer.h2m

for cmd in $AFCOD $AFCOCLI $AFCOTX $WALLET_TOOL $AFCOQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${AFCOVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${AFCOVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
