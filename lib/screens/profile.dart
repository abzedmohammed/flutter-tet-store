import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tet_store/customer_screens/customer_orders.dart';
import 'package:tet_store/customer_screens/wishlist.dart';
import 'package:tet_store/screens/cart.dart';
import 'package:tet_store/utilities/notification_handler.dart';
import 'package:tet_store/widgets/alert_dialog.dart';
import 'package:tet_store/widgets/app_bar_widgets.dart';

final dio = Dio();

String url = dotenv.env['API_URL'] ?? '';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> user = {};
  var uid = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool isProcessing = false;

  @override
  void initState() {
    _fetchUserProfile();
    super.initState();
  }

  void _fetchUserProfile() async {
    setState(() {
      isProcessing = true;
    });
    try {
      final response = await dio.get('$url/api/user?usrCid=$uid');

      if (response.data['success'] == true) {
        setState(() {
          user.addAll(response.data['data']['result']);
          isProcessing = false;
        });
      } else {
        setState(() {
          user.addEntries({
            MapEntry('usrNames', 'Guest'),
            MapEntry('usrEmail', 'example@email.com'),
            MapEntry('usrPhone', '0700 000 000'),
            MapEntry('usrAddress', 'Nairobi, Kenya'),
            MapEntry('usrAvatar', null),
          });
          isProcessing = false;
        });
      }
    } catch (e) {
      FirebaseAuth.instance.signOut();
      MyMessageHandler.showSnackBar(_scaffoldKey, 'User not found');

      if (!mounted) return;
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('/welcome_screen');
    }
  }

  void _printUser() {
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return isProcessing
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Stack(
            children: [
              Container(
                height: 230,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.yellow, Colors.brown],
                  ),
                ),
              ),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    elevation: 0,
                    centerTitle: true,
                    expandedHeight: 140,
                    backgroundColor: Colors.white,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        return FlexibleSpaceBar(
                          title: AnimatedOpacity(
                            opacity: constraints.biggest.height <= 120 ? 1 : 0,
                            duration: Duration(milliseconds: 200),
                            child: Text(
                              'Account',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          background: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.yellow, Colors.brown],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25, left: 30),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        user['usrAvatar'] == null
                                            ? AssetImage('images/inapp/guest.jpg')
                                            : NetworkImage(
                                              '$url/files/${user['usrAvatar']}',
                                            ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Text(
                                      user['usrNames'].toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (ctx) => CartScreen(
                                              back: AppBarBackButton(),
                                            ),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: Text(
                                      'Cart',
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.yellow,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (ctx) => CustomerOrdersScreen(),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: Text(
                                      'Orders',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => WishlistScreen(),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: Text(
                                      'Wishlist',
                                      style: TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          color: Colors.grey.shade300,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                                child: Image(
                                  image: AssetImage('images/inapp/logo.jpg'),
                                ),
                              ),
                              ProfileCardTitle(title: '  Account info  '),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RepeatedListTile(
                                        title: 'Email address',
                                        subTitle: user['usrEmail'],
                                        icon: Icons.email,
                                      ),
                                      YellowDivider(),
                                      RepeatedListTile(
                                        title: 'Phone number',
                                        subTitle: user['usrPhone'],
                                        icon: Icons.phone,
                                      ),
                                      YellowDivider(),
                                      RepeatedListTile(
                                        title: 'Address',
                                        subTitle: user['usrAddress'],
                                        icon: Icons.location_pin,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ProfileCardTitle(title: '  Account settings  '),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RepeatedListTile(
                                        title: 'Edit profile',
                                        icon: Icons.edit,
                                        onPressed: () {},
                                      ),
                                      YellowDivider(),
                                      RepeatedListTile(
                                        title: 'Change password',
                                        icon: Icons.lock,
                                        onPressed: () {
                                          _printUser();
                                        },
                                      ),
                                      YellowDivider(),
                                      RepeatedListTile(
                                        title: 'Log out',
                                        icon: Icons.logout,
                                        onPressed: () async {
                                          MyAlertDialog.showMyDialog(
                                            context: context,
                                            title: 'Logout',
                                            message:
                                                'Are you sure you want to logout?',
                                            tapNo:
                                                () =>
                                                    Navigator.of(context).pop(),
                                            tapYes: () async {
                                              FirebaseAuth.instance.signOut();
                                              Navigator.pop(context);
                                              Navigator.of(
                                                context,
                                              ).pushReplacementNamed(
                                                '/welcome_screen',
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Divider(color: Colors.yellow, thickness: 1),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  const RepeatedListTile({
    super.key,
    required this.icon,
    this.onPressed,
    this.subTitle = '',
    required this.title,
  });

  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: subTitle.isEmpty ? null : Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileCardTitle extends StatelessWidget {
  const ProfileCardTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(thickness: 1, color: Colors.green),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(thickness: 1, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
