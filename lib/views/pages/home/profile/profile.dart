import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fripay/l10n/app_localizations.dart';
import 'package:fripay/views/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../controllers/authview/authview.dart';
import '../../../../gen/assets.gen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../gen/colors.gen.dart';
import '../../../utils/globalwidget/buttons/bigbutton.dart';
import '../../../utils/globalwidget/dialogs.dart';
import '../../../utils/globalwidget/space.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int _currentIndex = 3;
  bool _isLoading = true;
  bool _showSettingsOptions = false;
  bool _showSecurityOptions = false;
  XFile? image;
  bool sacnning = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authviewProvider);
    final user = authState.user;

    final fullName = (user?.firstname != null && user!.firstname.isNotEmpty)
        ? "${user.firstname} ${user.lastname}".trim()
        : (authState.account.isNotEmpty ? authState.account : "Utilisateur");

    final emailDisplay = (user?.email != null && user!.email!.isNotEmpty)
        ? user.email!
        : (user?.telephone ?? "Non renseigné");

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // Profile Header
                    _buildProfileHeader(fullName, emailDisplay),

                    const SizedBox(height: 32),

                    // Balance & KYC Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            "Balance",
                            "\$12,450",
                            Icons.account_balance_wallet_outlined,
                            isLoading: _isLoading,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInfoCard(
                            "KYC",
                            "Verified",
                            Icons.verified_user_outlined,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Options Group
                    _buildOptionsGroup([
                      _buildOptionTile(
                        icon: Icons.receipt_long_rounded,
                        title:
                            AppLocalizations.of(context)?.operations_title ??
                            "Opérations",
                        onTap: () =>
                            context.pushNamed(RoutesNames.Applications),
                      ),
                      _buildDivider(),
                      _buildExpandableOptionTile(
                        icon: Icons.settings_outlined,
                        title: "Paramètres",
                        isExpanded: _showSettingsOptions,
                        onTap: () => setState(
                          () => _showSettingsOptions = !_showSettingsOptions,
                        ),
                        children: [
                          _buildSubOption("Changer mot de passe"),
                          _buildSubOption("Préférences de langue"),
                          _buildSubOption("Notifications"),
                        ],
                      ),
                      _buildDivider(),
                      _buildOptionTile(
                        icon: Icons.code_rounded,
                        title: "Comptes développeurs (Dev)",
                        onTap: () => context.pushNamed(RoutesNames.DevAccounts),
                      ),
                      _buildDivider(),
                      _buildExpandableOptionTile(
                        icon: Icons.security_outlined,
                        title: "Sécurité",
                        isExpanded: _showSecurityOptions,
                        onTap: () => setState(
                          () => _showSecurityOptions = !_showSecurityOptions,
                        ),
                        children: [
                          _buildSubOption("Authentification 2FA"),
                          _buildSubOption("Appareils connectés"),
                        ],
                      ),
                      _buildDivider(),
                      _buildOptionTile(
                        icon: Icons.help_outline,
                        title: "Support",
                        onTap: () {},
                      ),
                    ]),

                    const SizedBox(height: 24),

                    // Logout Button
                    _buildOptionsGroup([
                      _buildOptionTile(
                        icon: Icons.logout_rounded,
                        title: "Déconnexion",
                        isLogout: true,
                        onTap: () => _sedeconnecter(context),
                      ),
                    ]),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileHeader(String fullName, String emailDisplay) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: "",
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset(Assets.icones.avatar.path, fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => showPicker(context),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFF8F9FA),
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          fullName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          emailDisplay,
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon, {
    bool isLoading = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue.shade500, size: 24),
          const SizedBox(height: 12),
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade50,
                  child: Container(
                    width: 80,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    final color = isLogout ? Colors.red.shade600 : const Color(0xFF111827);
    final iconColor = isLogout ? Colors.red.shade500 : Colors.blue.shade500;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isLogout ? Colors.red.shade50 : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableOptionTile({
    required IconData icon,
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.blue.shade500, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(children: children),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  Widget _buildSubOption(String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(
          left: 68,
          right: 20,
          top: 12,
          bottom: 12,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 68, right: 20),
      child: Divider(height: 1, color: Colors.grey.shade100),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1.0),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) context.pushNamed(RoutesNames.Home);
          if (index == 1) context.pushNamed(RoutesNames.Payer);
          if (index == 2) context.pushNamed(RoutesNames.AddCarte);
          if (index == 3) context.pushNamed(RoutesNames.Profil);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.grey.shade500,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.home_outlined),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.home),
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.swap_horiz),
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.credit_card_outlined),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.credit_card),
            ),
            label: 'Cartes',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.sentiment_satisfied_alt),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.sentiment_satisfied),
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          image = pickedImage;
          sacnning = true;
        });
      }
    } catch (e) {
      setState(() {
        image = null;
        sacnning = false;
      });
    }
  }

  void showPicker(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galerie'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _sedeconnecter(BuildContext context) async {
    openDialogBox(
      context,
      "",
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Container(
          alignment: Alignment.center,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)?.wntdisconect ??
                    "Voulez-vous vous déconnecter ?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Color(0xFF111827),
                ),
              ),
              Space.verticale(heigth: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigButton(
                    labelText: AppLocalizations.of(context)?.y ?? "Oui",
                    backgroundClr: ColorName.bleu,
                    size: 15,
                    onPressed: () async {
                      Navigator.of(context).pop();
                      openDialogBox(context, "", const CustomAlertDialog());
                      bool state = await ref
                          .read(authviewProvider.notifier)
                          .logout();
                      if (state && context.mounted) {
                        context.pop();
                        context.goNamed(RoutesNames.Connexion);
                      }
                    },
                  ),
                  BigButton(
                    labelText: AppLocalizations.of(context)?.n ?? "Non",
                    backgroundClr: ColorName.webViolet,
                    color: ColorName.webwhite,
                    size: 15,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
