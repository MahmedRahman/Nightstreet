import 'package:krzv2/component/views/branches_sort_box_view.dart';
import 'package:krzv2/component/views/gender_selection_view.dart';
import 'package:krzv2/component/views/profile_gender_selector_view.dart';

extension GenderArabicText on Gender {
  String get arabicText {
    switch (this) {
      case Gender.male:
        return 'رجالي';
      case Gender.female:
        return 'نسائي';
      case Gender.both:
        return 'الإثنين معاً';
      default:
        return '';
    }
  }
}

extension ProfileGenderArabicText on ProfileGender {
  String get profileArabicText {
    switch (this) {
      case ProfileGender.male:
        return 'ذكر';
      case ProfileGender.female:
        return 'أنثى';

      default:
        return '';
    }
  }
}

extension BranchSortEnumArabicText on BranchSortEnum {
  String get branchArabicText {
    switch (this) {
      case BranchSortEnum.nearest:
        return 'الأقرب';
      case BranchSortEnum.topRated:
        return 'الاعلى تقييماً';

      default:
        return '';
    }
  }
}
