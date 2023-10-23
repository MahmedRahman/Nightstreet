import 'package:flutter/material.dart';
import 'package:krzv2/app/modules/wallet/model/transaction_model.dart';
import 'package:krzv2/utils/app_colors.dart';

class TransactionTableComponent extends StatelessWidget {
  const TransactionTableComponent({
    Key? key,
    required this.transactionsList,
  }) : super(key: key);

  final List<Transaction> transactionsList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.greyColor4,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: AppColors.borderColor2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.5,
            right: 12.5,
          ),
          child: Table(
            border: const TableBorder(
              horizontalInside: BorderSide(
                color: AppColors.borderColor2,
              ),
              verticalInside: BorderSide.none,
            ),
            columnWidths: const {
              0: FlexColumnWidth(1.0),
              1: FlexColumnWidth(3.0),
              2: FlexColumnWidth(1.5),
            },
            children: [
              _tableHeader(),
              ...transactionsList.map(
                (transaction) {
                  return TableRow(
                    children: [
                      _operationTypeColumn(
                        type: transaction.type,
                      ),
                      _operationDescriptionColumn(
                        description: transaction.description,
                      ),
                      _operationAmountColumn(
                        amount: num.tryParse(transaction.amount.toString())!,
                      ),
                    ],
                  );
                },
              ).toList()
            ],
          ),
        ),
      ),
    );
  }

  TableRow _tableHeader() {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'العملية',
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.blackColor,
                letterSpacing: 0.21,
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'الوصف',
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.blackColor,
                letterSpacing: 0.21,
              ),
            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'المبلغ',
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.blackColor,
                letterSpacing: 0.21,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _operationTypeColumn({required String type}) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (type == 'إيداع') {
      backgroundColor = AppColors.greenColor.withOpacity(0.08);
      borderColor = AppColors.greenColor;
      textColor = AppColors.greenColor;
    } else if (type == 'سحب') {
      backgroundColor = AppColors.errorColor.withOpacity(0.08);
      borderColor = AppColors.errorColor;
      textColor = AppColors.errorColor;
    } else if (type == 'خصم') {
      backgroundColor = AppColors.mainColor.withOpacity(0.08);
      borderColor = AppColors.mainColor;
      textColor = AppColors.mainColor;
    } else {
      // Default values for unknown types
      backgroundColor = Colors.grey.withOpacity(0.08);
      borderColor = Colors.grey;
      textColor = Colors.black;
    }

    return _buildOperationTypeCell(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      textColor: textColor,
      type: type,
    );
  }

  Widget _buildOperationTypeCell({
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
    required String type,
  }) {
    return TableCell(
      child: Center(
        child: Container(
          width: 56.0,
          height: 26.0,
          margin: const EdgeInsets.only(top: 3, bottom: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: backgroundColor,
            border: Border.all(
              width: 1,
              color: borderColor,
            ),
          ),
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                fontSize: 14.0,
                color: textColor,
                letterSpacing: 0.28,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }

  Widget _operationDescriptionColumn({required String description}) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          description,
          style: const TextStyle(
            fontSize: 13.0,
            color: AppColors.greyColor,
            letterSpacing: 0.195,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget _operationAmountColumn({required num amount}) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          '$amount ر.س',
          style: const TextStyle(
            fontSize: 13.0,
            color: AppColors.greyColor,
            height: 1.46,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
