// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef ANGCOIN_QT_ANGCOINADDRESSVALIDATOR_H
#define ANGCOIN_QT_ANGCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class ANGCOINAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ANGCOINAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** ANGCOIN address widget validator, checks for a valid angcoin address.
 */
class ANGCOINAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ANGCOINAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // ANGCOIN_QT_ANGCOINADDRESSVALIDATOR_H
