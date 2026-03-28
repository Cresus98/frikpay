import 'package:flutter/material.dart';
import 'package:fripay/views/routes.dart';
import 'package:fripay/views/utils/globalwidget/general_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../utils/constantes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../utils/globalwidget/buttons/clickable.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _expanded = false;
  bool _isLoading = true;
  bool _showSettingsOptions = false;
  bool _showSecurityOptions = false;
  XFile? image;
  bool sacnning = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  GeneralScaffold(content: Column(
      children: [
        //  HEADER
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration:  BoxDecoration(
            color: ColorName.bleu,
            borderRadius: const  BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 92,
                    width: 92,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: white),
                    child: CachedNetworkImage(
                      imageUrl:"",
                     // finanFaImages + finanFaProfile + clients.photo,
                      imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ))),
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(
                        color: ColorName.bleu,
                        backgroundColor: ColorName.webwhite,
                      ),
                      errorWidget: (context, url, error) =>
                          Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    Assets.icones.avatar.path),
                                fit: BoxFit.cover,
                              ))),
                      //  const Icon(Icons.person,color: Colors.red,),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Clickable(
                      onClick: () {
                        showPicker(context);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorName.vert),
                        child: const Padding(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            Icons.camera_alt,
                            color: white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "John Doe",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                "johndoe@email.com",
                style: TextStyle(color: Colors.white.withOpacity(0.9)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // CARDS INFO
        Clickable(onClick: () => setState(() {
          _expanded=!_expanded;
        }), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _animatedInfoCard("Balance", "\$12,450", isLoading: _isLoading),
            _animatedInfoCard("KYC", "Verified"),
          ],
        )),


        const SizedBox(height: 20),

        // LISTE D’OPTIONS
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _expandableOptionTile(
                icon: Icons.settings,
                title: "Paramètres",
                isExpanded: _showSettingsOptions,
                onTap: () =>
                    setState(() => _showSettingsOptions = !_showSettingsOptions),
                children: [
                  _subOption("Changer mot de passe"),
                  _subOption("Préférences de langue"),
                  _subOption("Notifications"),
                ],
              ),
              _optionTile(
                Icons.developer_mode,
                "Dev — comptes développeurs",
                onTap: () => context.pushNamed(RoutesNames.Developpeurs),
              ),
              _optionTile(
                Icons.receipt_long,
                "Liste des opérations",
                onTap: () => context.pushNamed(RoutesNames.Operations),
              ),
              _expandableOptionTile(
                icon: Icons.security,
                title: "Sécurité",
                isExpanded: _showSecurityOptions,
                onTap: () =>
                    setState(() => _showSecurityOptions = !_showSecurityOptions),
                children: [
                  _subOption("Authentification 2FA"),
                  _subOption("Appareils connectés"),
                ],
              ),
              _optionTile(Icons.help_outline, "Support"),
              _optionTile(Icons.logout, "Déconnexion", isLogout: true),
            ],
          ),
        ),
      ],
    ));
  }

  // AnimatedContainer pour balance avec shimmer
  Widget _animatedInfoCard(String title, String value, {bool isLoading = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      width: _expanded ? 170 : 150,
      height: _expanded ? 120 : 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading
              ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 80,
              height: 20,
              color: Colors.grey.shade300,
            ),
          )
              : Text(
            value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // Option simple
  Widget _optionTile(
    IconData icon,
    String title, {
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: isLogout ? Colors.red : Colors.blueAccent),
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isLogout ? Colors.red : Colors.black87),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap ?? () {},
      ),
    );
  }

  // Option avec sous-menu animé
  Widget _expandableOptionTile({
    required IconData icon,
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.blueAccent),
            title: Text(title,
                style:
                const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
            trailing: AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Icon(Icons.keyboard_arrow_down),
            ),
            onTap: onTap,
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(children: children),
            crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  //  Sous-options
  Widget _subOption(String label) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 70, right: 20),
      title: Text(label, style: const TextStyle(color: Colors.black54)),
      onTap: () {

      },
    );
  }


  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        setState(() {
          image = pickedImage;
          sacnning = true;
          setState(() {});
        });
      }
    } catch (e) {
      image = null;
      sacnning = false;
      setState(() {});
    }
  }

  showPicker(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
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
                      //Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    getImage(ImageSource.camera);
                    context.pop();
                    //Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}



