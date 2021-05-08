// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef AFCO_QT_AFCOADDRESSVALIDATOR_H
#define AFCO_QT_AFCOADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class AFCOAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit AFCOAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** AFCO address widget validator, checks for a valid afco address.
 */
class AFCOAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit AFCOAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // AFCO_QT_AFCOADDRESSVALIDATOR_H
