import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/data/repositories/encaissement_repository.dart';
import 'package:fripay/data/repositories/payer_repository.dart';

/// Instance unique par session (mock persistant ; remote stateless côté serveur).
final encaissementRepositoryProvider = Provider<EncaissementRepository>((ref) {
  return EncaissementRepository.createDefault();
});

final payerRepositoryProvider = Provider<PayerRepository>((ref) {
  return PayerRepository.createDefault();
});
