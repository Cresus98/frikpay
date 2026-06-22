// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardInfoImpl _$$CardInfoImplFromJson(Map<String, dynamic> json) =>
    _$CardInfoImpl(
      civility: json['civility'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      nationality: json['nationality'] as String? ?? '',
      birthday: json['birthday'] as String? ?? '',
      birthplace: json['birthplace'] as String? ?? '',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      profession: json['profession'] as String? ?? '',
      carteExpiryDate: json['carteExpiryDate'] as String? ?? '',
      statusCarte: json['statusCarte'] as String? ?? '',
      accountId: json['accountId'] as String? ?? '',
    );

Map<String, dynamic> _$$CardInfoImplToJson(_$CardInfoImpl instance) =>
    <String, dynamic>{
      'civility': instance.civility,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'nationality': instance.nationality,
      'birthday': instance.birthday,
      'birthplace': instance.birthplace,
      'address': instance.address,
      'city': instance.city,
      'profession': instance.profession,
      'carteExpiryDate': instance.carteExpiryDate,
      'statusCarte': instance.statusCarte,
      'accountId': instance.accountId,
    };

_$CardTransactionImpl _$$CardTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$CardTransactionImpl(
      transactionId: json['transactionId'] as String? ?? '',
      transactionDate: json['transactionDate'] as String? ?? '',
      base: json['base'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      baseAmount: json['baseAmount'] as String? ?? '',
      fee: json['fee'] as String? ?? '',
      totalAmount: json['totalAmount'] as String? ?? '',
      balance: json['balance'] as String? ?? '',
      carteCreditId: json['carteCreditId'] as String? ?? '',
      carteDebitId: json['carteDebitId'] as String? ?? '',
      accountId: json['accountId'] as String? ?? '',
      partnerId: json['partnerId'] as String? ?? '',
      status: json['status'] as String? ?? '',
      carteId: json['carteId'] as String? ?? '',
      operation: json['operation'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$CardTransactionImplToJson(
        _$CardTransactionImpl instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'transactionDate': instance.transactionDate,
      'base': instance.base,
      'currency': instance.currency,
      'baseAmount': instance.baseAmount,
      'fee': instance.fee,
      'totalAmount': instance.totalAmount,
      'balance': instance.balance,
      'carteCreditId': instance.carteCreditId,
      'carteDebitId': instance.carteDebitId,
      'accountId': instance.accountId,
      'partnerId': instance.partnerId,
      'status': instance.status,
      'carteId': instance.carteId,
      'operation': instance.operation,
      'description': instance.description,
    };

_$CardPciResponseImpl _$$CardPciResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CardPciResponseImpl(
      url: json['url'] as String? ?? '',
      msg: json['msg'] as String? ?? '',
    );

Map<String, dynamic> _$$CardPciResponseImplToJson(
        _$CardPciResponseImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'msg': instance.msg,
    };
