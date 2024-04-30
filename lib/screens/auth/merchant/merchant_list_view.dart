import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mainstreet/common/common_colors.dart';
import 'package:mainstreet/common/common_style.dart';
import 'package:mainstreet/models/merchant_model.dart';
import 'package:mainstreet/screens/bottom_navbar/bottom_navbar_merchant.dart';

class MerchantListView extends StatefulWidget {
  final Merchant merchant;

  const MerchantListView({
    super.key,
    required this.merchant,
  });

  @override
  State<MerchantListView> createState() => _MerchantListViewState();
}

class _MerchantListViewState extends State<MerchantListView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome,',
                        style: CommonStyle.getInterFont(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '\n${widget.merchant.businessName}',
                        style: CommonStyle.getInterFont(
                          fontSize: 24,
                          height: 1.8,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Review your details before continuing to your dashboard',
                  style: CommonStyle.getInterFont(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        buildSingleItem(
                          icon: Icons.account_circle,
                          title: 'Business name',
                          value: widget.merchant.businessName ?? '',
                        ),
                        buildSingleItem(
                          icon: Icons.lock,
                          title: 'ID',
                          value: widget.merchant.id ?? '',
                        ),
                        buildSingleItem(
                          icon: Icons.money,
                          title: 'Curreny',
                          value: widget.merchant.currency ?? '',
                        ),
                        buildSingleItem(
                          icon: Icons.location_city,
                          title: 'Location ID',
                          value: widget.merchant.mainLocationId ?? '',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CommonColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const BottomNavbarMerchant(
                            currentIndex: 0,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Continue to Dashboard',
                      style: CommonStyle.getInterFont(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSingleItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: CommonColors.primaryColor,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CommonStyle.getInterFont(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: CommonStyle.getInterFont(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
