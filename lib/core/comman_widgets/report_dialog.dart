import 'package:alert_her/core/comman_widgets/large_text_field.dart';
import 'package:alert_her/core/comman_widgets/normal_text_field.dart';
import 'package:alert_her/core/comman_widgets/primary_button.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/services/snackbar_manager.dart';
import 'package:alert_her/localizations/app_localizations.dart';
import 'package:alert_her/modules/user/presentation/viewmodels/home_view_model.dart';
import 'package:alert_her/modules/user/presentation/widgets/custom_spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'text_sub_heading.dart';
import '../utils/sb.dart';

class ReportDialog extends StatelessWidget {
  final List<String> reportType;
  final String id;
  final String report;

  const ReportDialog({
    Key? key,
    required this.reportType,
    required this.id,
    required this.report,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 420,
        child: Consumer<HomeViewModel>(builder: (mContext, homeVM, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: TextSubHeading(
                text: AppLocalizations.of(context).translate('report'),
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: MyColors.black,
              )),
              SB.h(25),
              TextSubHeading(
                text: AppLocalizations.of(context).translate('reportType'),
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: MyColors.blackLight,
              ),
              SB.h(10),
              CustomSpinner(
                items: reportType,
                selectedItem: reportType.first,
                onChanged: (selectedValue) {
                  homeVM.selectedReportType = selectedValue!;
                },
              ),
              SB.h(15),
              TextSubHeading(
                text: AppLocalizations.of(context).translate('reason'),
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: MyColors.blackLight,
              ),
              SB.h(10),
              LargeTextField(
                controller: homeVM.reasonController,
                hintText:
                    AppLocalizations.of(context).translate('writeYourReason'),
              ),
              SB.h(20),
              PrimaryButton(
                buttonText:
                    AppLocalizations.of(context).translate('submitReport'),
                fontWeight: FontWeight.w700,
                textSize: 16,
                isLoading: homeVM.isSubmitReportLoading,
                onPressed: () {
                  var reason = homeVM.reasonController.text;
                  if (homeVM.selectedReportType.isEmpty || homeVM.selectedReportType == AppLocalizations.of(context).translate('select')) {
                    SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('pleaseSelectReasonType'));
                  } else if (reason.isEmpty) {
                    SnackbarManager().showTopSnack(context, AppLocalizations.of(context).translate('reasonNumberCannotBeEmpty'));
                  }
                  else {
                    homeVM.handleReportOnUserOrReview(context,id,report);
                  }
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
