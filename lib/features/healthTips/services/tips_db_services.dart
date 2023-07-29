import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disaoled_people/features/healthTips/models/tip.dart';

class TipsDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Tip>> getTips({required String diseaseName}) async {
    List<Tip> tips = [];
    print(diseaseName);
    var query = await _db.collection('tips').where('disease_name', isEqualTo: diseaseName).get();

    for (var doc in query.docs) {
      tips.add(Tip.fromFirestore(doc));
    }
    return tips;
  }

  Future<void> addTibs() async {
    for (var tip in tips) {
      try {
        await _db.collection('tips').add(tip.toJson());
      } on FirebaseException catch (e) {
        print(e.toString());
      }
    }
  }
}

List<Tip> tips = [
  const Tip(id: '', containt: 'تقدير الحالة النفسية', diseaseName: 'التوحد'),
  const Tip(id: '', containt: 'محاولة تقريب و دمج الطفل مع أقرانه', diseaseName: 'التوحد'),
  const Tip(id: '', containt: 'تنمية الثقة بالنفس والاستقلالية', diseaseName: 'التوحد'),
  const Tip(id: '', containt: 'إشغال الطفل عن الحلركات النمطية', diseaseName: 'التوحد'),
  const Tip(id: '', containt: 'التركيز على التواصل مع الآخرين', diseaseName: 'التوحد'),
  const Tip(id: '', containt: 'التأكد من فهم الطفل لما نطلبه منه وقدرته على النجاح به ', diseaseName: 'التوحد'),
  const Tip(id: '', containt: 'التدرب على اللعب', diseaseName: 'التوحد'),
  const Tip(id: '', containt: 'قدرة الطفل على تقبل التغيير', diseaseName: 'التوحد'),
  const Tip(id: '', containt: 'تقبل الاسرة الطفل بحالته الخاصة ', diseaseName: 'متلازمة داون'),
  const Tip(id: '', containt: 'إشعار الطفل على انه طفل طبيعي لا يختلف عن الاخرين ', diseaseName: 'متلازمة داون'),
  const Tip(id: '', containt: 'عدم الشعور بأي حرج تجاه وجوده بين الناس ', diseaseName: 'متلازمة داون'),
  const Tip(id: '', containt: 'دعم ثقته بنفسه ليستطيع التعامل مع بقية افراد المجتمع', diseaseName: 'متلازمة داون'),
  const Tip(id: '', containt: 'اكتشاف ميزات ومواهب الطفل مع تطوير قدراته وامكاناته', diseaseName: 'متلازمة داون'),
  const Tip(
      id: '', containt: 'عدم التسرع في تفسير سلوك الطفل المنغولي والصبر في التعامل معه ', diseaseName: 'متلازمة داون'),
  const Tip(
      id: '',
      containt: 'التركيز على البرامج والتطبيقات التعليمية المخصصة لهؤلاء الأطفال مما يعمل على صقل قدراته الذهنيه',
      diseaseName: 'متلازمة داون'),
  const Tip(id: '', containt: 'تثبيت المصاب عند الإصابة بنوبة', diseaseName: 'الصرع'),
  const Tip(id: '', containt: 'عدم التجمهر حول المصاب ', diseaseName: 'الصرع'),
  const Tip(id: '', containt: 'وضع أي جسم في فم المصاب او بين اسنانه ', diseaseName: 'الصرع'),
  const Tip(id: '', containt: 'لا تزعر وتفترض ان المصاب على علم بما يحدث او ما حدث ', diseaseName: 'الصرع'),
  const Tip(id: '', containt: 'إعطاء المصاب أي نوع من الطعام او الشراب حتى يعود الى وعيه', diseaseName: 'الصرع'),
  const Tip(id: '', containt: 'في حال استمرار النوبة اكثر من خمس دقائق ينبغي طلب الإسعاف ', diseaseName: 'الصرع'),
  const Tip(id: '', containt: 'تشجيعهم على  ممارسة الرياضة ', diseaseName: 'الإضطرابات العاطفية'),
  const Tip(id: '', containt: 'إبعادهم عن شرب كميات كبيرة من الكافيين ', diseaseName: 'الإضطرابات العاطفية'),
  const Tip(id: '', containt: 'تناول بعض الادوية المهدئة بعد استشارة الطبيب ', diseaseName: 'الإضطرابات العاطفية'),
  const Tip(
      id: '', containt: 'رعاية تنمية الطفل حتى يتمكن من العيش بشكل مستقل قدر الإمكان ', diseaseName: 'الشلل الدماغي'),
  const Tip(
      id: '',
      containt: 'تحسين مهاراتهم الحركية بمساعدة العلاج التقليدي والبديل عن الادوية والجراحة ',
      diseaseName: 'الشلل الدماغي'),
  const Tip(id: '', containt: 'حثهم على زيارة علماء النفس لتقييم القدرة والسلوك', diseaseName: 'الشلل الدماغي'),
];
