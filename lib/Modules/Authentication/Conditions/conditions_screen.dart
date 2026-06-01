// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:Tanmeyah/Modules/Authentication/Conditions/conditions_controller.dart';
import 'package:Tanmeyah/Utilities/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Theme/themeclass.dart';
import '../../../Widgets/base_appbar.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Utilities/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


class ConditionsScreen extends StatefulWidget {
  static const String routeName = "/conditionsScreen";

  const ConditionsScreen({Key? key}) : super(key: key);

  @override
  _ConditionsScreenState createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends StateMVC<ConditionsScreen> {
  _ConditionsScreenState() : super(ConditionsController()) {
    con = ConditionsController();
  }

  late ConditionsController con;

  @override
  void initState() {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    _analytics.logEvent(
        name: 'open_conditions_screen',
        parameters: <String,Object>{
          "title" : "open_conditions_screen"
        }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeClass.whiteColor,
      appBar: BaseAppBar.main(
        title: "privacy".tr,
      ),
      body: SafeArea(
        child: LoadingScreen(
          loading: con.loading,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w,),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  AppTextMedium(title: "سياسة الخصوصية المكملة لشركة تنميه"),
                  AppTextRegular(title: "شركة تنميه لخدمات المشروعات متناهية الصغر ش.م.م (شركة تنميه) إحدى الشركات التابعة لشركة مجموعة إي اف چي القابضة ش.م.م. (;المجموعة المالية;). وبناء عليه، فإن https://efghermes.com/ar/efg-hermes-privacy-policy (&quot;سياسة المجموعة المالية;) تنطبق على البيانات التي تعالجها شركة تنميه. وفضلاً عن ذلك، تنطبق سياسة الخصوصية المكملة هذه (&quot;السياسة المكملة&quot;) أيضاً. لذلك، فإنه من الضروري أن تقرأوتفهم سياسة المجموعة ",
textAlign: TextAlign.start,),
                  AppTextMedium(title: "1. ما هي المعلومات التي نستعملها؟"),
                  AppTextRegular(title: """1-1 المعلومات التي تقدمها لنا أنت تقدم لنا معلومات خاصة بالاتصال وتعريف الهوية (الاسم، تاريخ الميلاد، بطاقة الرقم القومي، المهنة، العنوان، عنوان البريد الإلكتروني، رقم الهاتف المحمول ... الخ) الخاصة بك حين تستخدم إحدى الخدمات الخاصة بشركة تنميه، على سبيل المثال حين تتقدم للحصول على تمويل متناهي الصغر منا، أو تتصل بنا، أو تستعمل تطبيق الهاتف المحمول. برجاء مراعاة أنه – حين تستخدم خدماتنا – يجب أن تقدم البيانات الشخصية الخاصة بك أنت فقط. ويجوز لك أن تغير المعلومات الخاصة بملفك الشخصي مثل بيانات الاتصال وغيرها من الإعدادات في أي وقت على تطبيق الهاتف المحمول.
1-2 المعلومات التي نجمعها عنك بناء على نوعية الخدمات الخاصة بنا التي تستعملها، قد نجمع أي من البيانات التالية الخاصة بك سواء بنفسنا أو من خلال الغير (مثل وكالات الاستعلام الائتماني، أو قواعد البيانات العامة):  معلومات خاصة بالاتصال وتعريف الهوية: الاسم، تاريخ الميلاد، بطاقة الرقم القومي، المهنة، العنوان، عنوان البريد الإلكتروني، رقم الهاتف المحمول ... الخ.
 معلومات خاصة بالمنتجات / الخدمات: تفاصيل المنتجات / الخدمات التي تشتريها أو تطلبها، مثل نوعية المنتجات أو رقم الشحن الخاص بها.
 المعلومات المالية: المعلومات التي يتم الحصول عليها من الغير عن أمورك المالية، مثل دخلك، والتزاماتك التمويلية، وبياناتك التمويلية التاريخية، وتاريخ التزاماتك المسددة والتمويل الذي حصلت عليه، ورقم الحساب البنكي، واسم صاحب الحساب وباقي التفاصيل البنكية.
 سدادك لالتزاماتك مع شركة تنميه، والبيانات الفنية مثل وقت تحميل الصفحات، وأخطاء التحميل، وتفضيلاتك الشخصية، وتفاصيل تفاعلاتك مع خدمة عملاء شركة تنميه... الخ. المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه: نوعية استخدامك للخدمات، بما في ذلك تفاصيل الالتزامات الحالية والسابقة وتاريخ
 المكالمات المسجلة: قد نقوم بتسجيل المكالمات الهاتفية حين تقوم بالاتصال بخدمة العملاء.
 الإعدادات الخاصة بالمنطقة الزمنية، الموقع، نظام التشغيل، المنصة، دقة الشاشة. المعلومات المتصلة بالجهاز: على سبيل المثال عنوان بروتوكول الأنترنت، الإعدادات الخاصة باللغة، الإعدادات الخاصة بالمتصفح،
2. ما هي بياناتك الشخصية التي نقوم بمعالجاتها، ولأي غرض، وبناء على أي سبب قانوني؟
بناء على نوعية الخدمات الخاصة بنا التي تستعملها، قد تقوم شركة تنميه بمعالجة بياناتك الشخصية للأغراض المبينة فيما يلي وبناء على الأسباب القانونية المحددة لكل غرض منها.""",textAlign: TextAlign.start,),
                  AppTextMedium(title: "2-1 المعالجة لأغراض تقديم الخدمات الخاصة بنا",textAlign: TextAlign.start,),
                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "ادارة علاقتنا معك كعميل."),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: " معلومات خاصة بالاتصال وتعريف الهوية،معلومات خاصة بالمنتجات / الخدمات، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه، المعلومات المتصلة  بالجهاز.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "تنفيذ التعاقد."),
                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "تكوين وإرسال المعلومات في شكل إلكتروني(بخلاف الدعاية)."),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: " معلومات خاصة بالاتصال وتعريف الهوية،معلومات خاصة بالمنتجات / الخدمات، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه، المعلومات المتصلة  بالجهاز.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "تنفيذ التعاقد."),

                  SizedBox(height: 6.h,),


                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "تحديد أفضل السبل للاتصال بك بخصوصالمعلومات المتعلقة بالمطالبات غير المسددة.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: " معلومات خاصة بالاتصال وتعريف الهوية،المعلومات المالية، المعلومات الخاصة بالتفاعلبينك وبين شركة تنميه.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "لشركة تنميه مصلحة مشروعة في الاتصال بك بأفضل وسيلة ممكنة. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض.",textAlign: TextAlign.start,),

                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "القيام بالفحوصات الائتمانية قبل منح تمويل متناهي الصغر. وهذه المعالجة تتضمن التنميط.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "معلومات خاصة بالاتصال وتعريف الهوية، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه. ",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "تنفيذ التعاقد.",textAlign: TextAlign.start,),

                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "الوقاية من الهجمات الخاصة بتكنولوجيا المعلومات كجزء من جهودنا لحماية والحفاظ على خدماتنا..",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "معلومات خاصة بالاتصال وتعريف الهوية، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه. ",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: " لشركة تنميه مصلحة مشروعة في حماية خدماتنا من المخاطر. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض.   ",textAlign: TextAlign.start,),

                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "نقل بياناتك للتجار ومقدمي الخدمات وغيرهم من المتلقين والشركات التابعة والشقيقة.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "كافه انواع البيانات الشخصيه المحدده بالقسم 1 ",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: " يعتمد ذلك على نوعية المتلقين. تكون لشركة تنميه، على سبيل المثال، مصلحة مشروعة في التعامل مع مقدمي الخدمات من الغير من أجل تقديم الخدمات الخاصة بنا، كما قد نكون ملزمين قانوناً بنقل بياناتك للسلطات المعنية. ",textAlign: TextAlign.start,),

                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "القيام بشكل متسمر بإجراء تحليلات ائتمانية أو خاصة بالمخاطر، ومنع الاحتيال، وإدارة المخاطر. وهذه المعالجة تتضمن التنميط.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "معلومات خاصة بالاتصال وتعريف الهوية، معلومات خاصة بالمنتجات / الخدمات، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شكة تنميه، المعلومات المتصلة بالجهاز. ",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "لشركة تنميه مصلحة مشروعة في القيام بشكل متسمر بإجراء تحليلات ائتمانية أو خاصة بالمخاطر. وبالإضافة لذلك، فإن شركة تنميه وأشخاص آخرين (بشكل رئيسي عملائنا) لديهم مصلحة مشروعة في إدارة المخاطر الخاصة بنشاط شركة تنميه. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض. كما أن شركة تنميه ملتزمة قانوناً بالتعرف على هوية عملاءها. ",textAlign: TextAlign.start,),


                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "استرجاع المديونية المستحقة، أي تحصيل وحوالة المستحقات. وهذه المعالجة تتضمن التنميط.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "معلومات خاصة بالاتصال وتعريف الهوية، معلومات خاصة بالمنتجات / الخدمات، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه، المعلومات المتصلة بالجهاز. ",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "لشركة تنميه مصلحة مشروعة في تحصيل وحوالة المستحقات. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض.",textAlign: TextAlign.start,),


                  SizedBox(height: 6.h,),


                  AppTextMedium(title: "2-2 تطوير المنتجات والأبحاث",textAlign: TextAlign.start,),

                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "إجراء تحليل للبيانات بغرض تطوير المنتجات واختبارها.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "  معلومات خاصة بالاتصال وتعريف الهوية، معلومات خاصة بالمنتجات / الخدمات، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه، المعلومات المتصلة بالجهاز.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "لشركة تنميه مصلحة مشروعة في إجراء تحليلات للبيانات بغرض تطوير المنتجات واختبارها. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض.",textAlign: TextAlign.start,),


                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "تيسير الأبحاث الداخلية وتكوين النماذج الإحصائية.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "معلومات خاصة بالاتصال وتعريف الهوية، معلومات خاصة بالمنتجات / الخدمات، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه، المعلومات المتصلة بالجهاز.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "لشركة تنميه مصلحة مشروعة في إجراء تحليلات للبيانات بغرض تطوير المنتجات واختبارها. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض.",textAlign: TextAlign.start,),


                  AppTextMedium(title: "2-3 الالتزام بالقوانين والمطالبات القانونية",textAlign: TextAlign.start,),



                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "الالتزام بالقوانين الساريه",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "معلومات خاصة بالاتصال وتعريف الهوية، معلومات خاصة بالمنتجات / الخدمات، المعلومات المالية، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه، المعلومات المتصلة بالجهاز.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "الالتزام بالقانون",textAlign: TextAlign.start,),

                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "حماية شركة تنميه من المطالبات القانونية وتفعيل المطالبات القانونية من قبل شركة تنميه.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "كافه انواع البيانات الشخصيه المحدده بالقسم 1 ",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "لشركة تنميه مصلحة مشروعة في إجراء تحليلات للبيانات بغرض تطوير المنتجات واختبارها. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض.",textAlign: TextAlign.start,),



                  AppTextMedium(title: "2-4 الأغراض الترويجية",textAlign: TextAlign.start,),



                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "اختيار الدعايه الموجهه لك",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "معلومات خاصة بالمنتجات / الخدمات، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه، المعلومات المتصلة بالجهاز.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "لشركة تنميه مصلحة مشروعة في اختيار نوع الدعاية التي تستقبلها. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض. ",textAlign: TextAlign.start,),

                  SizedBox(height: 6.h,),

                  AppTextRegular(title: "غرض المعالجه",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "تقديم روابط للرعاة والتسويق للمنتجات الخاصة بالغير وبشركاتنا التابعة والشقيقة.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "نوعية البيانات الشخصية",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "معلومات خاصة بالمنتجات/ الخدمات، المعلومات الخاصة بالتفاعل بينك وبين شركة تنميه، المعلومات المتصلة بالجهاز.",textAlign: TextAlign.start,),
                  AppTextRegular(title: "السبب القانوني",fontWeight: FontWeight.w600,),
                  AppTextRegular(title: "لشركة تنميه مصلحة مشروعة في إجراء تحليلات للبيانات بغرض تطوير المنتجات واختبارها. ونحن نتأكد من أن المعالجة التي تتم لهذا الغرض ضرورية لمراعاة هذه المصلحة المشروعة وأن هذه المصلحة تتجاوز مصلحتك في عدم معالجة بياناتك الشخصية لهذا الغرض.",textAlign: TextAlign.start,),


                  AppTextMedium(title: "3. التنميط واتخاذ القرارات بشكل آلي كم قبل شركه تنميه ",textAlign: TextAlign.start,),
                  AppTextRegular(title: "يقصد بـ التنميط  المعالجة الآلية للبيانات الشخصية لتقييم بعض العوامل الشخصية، على سبيل المثال لتحليل أو توقع خصائص متصلة بوضعك المالي أو تفضيلاتك. ونحن نستخدم التنميط بناء على بياناتك الشخصية المسجلة لدينا بشأنك حتى نقوم باتخاذ قرارات شخصية أو آلية فيما يخصك للأغراض التالية:",textAlign: TextAlign.start,),
                  AppTextRegular(title: """ 3-1 القرارات التي ليس لديها أثر قانوني أو جوهري مماثل
قد تقوم شركة تنميه باتخاذ القرارات التالية التي ليس لديها أثر قانوني أو جوهري مماثل بشأنك:
 توقع أي محتوى دعائي قد تكون مهتماً به.
 تحديد أية عروض قد تكون مناسبة لك.
 تحديد أفضل سبل الاتصال بك بشأن المطالبات غير المسددة.
 تحديد أي محتوى أنسب للعرض على تطبيق الهاتف المحمول الخاص بشركة تنميه. """,textAlign: TextAlign.start,),

              AppTextMedium(title: "3-2 القرارات لديها أثر قانوني أو جوهري مماثل",textAlign: TextAlign.start,),
              AppTextRegular(title: "يقصد بالقرارات الآلية ذات الأثر القانوني أو القرارات الآلية ذات الأثر الجوهري المماثل أن بعض القرارات المتصلة بخدماتنا قد يتم اتخاذها حصرياً بشكل آلي وبدون تأثير من موظفينا، ويكون لهذه القرارات أثر جوهري عليك كعميل. ومن خلال القرارات الآلية، فإن شركة تنميه تحسن من موضوعية وشفافية كيفية اتخاذ القرارات في شأن هذه الخدمات. ونحن قد نلجأ لهذا النوع من القرارات الآلية حين نقرر أن تقبل أو نرفض طلبك للحصول على تمويل متناهي الصغر، وفي حالة الموافقة، تحديد مستوى التمويل الذي تحصل عليه. وانت لديك الحق في عرض وجهة نظرك أو الاعتراض على القرار الآلي الذي يكون لديه أثر قانوني أو جوهري مماثل (بالإضافة للتنميط المتصل به) في أي وقت من خلال الاتصال بنا عن طريق البريد الإلكتروني المشار إليه بالقسم 5. وسوف يقوم فريق خدمة العملاء الخاص بنا بالتعامل مع حالتك في حينها.",textAlign: TextAlign.start,),

              AppTextMedium(title: "4. تحديث هذه السياسة المكملة"),

                  AppTextRegular(title: "نحن نعمل دائماً على تطوير نطاق خدماتنا ومنحك تجربة أفضل كمستخدم. ولا يقتصر ذلك فقط على الخدمات الحالية، بل يشمل أيضاً خدمات جديدة بمرور الوقت. لذلك، فمن الهام أن تقوم بقراءة هذه السياسة المكملة في كل مرة تستخدم فيها خدمة من خدمات شركة تنميه، حيث أن معالجة بياناتك الشخصية قد تتغير عن أخر مرة استخدمت فيها خدماتنا.",textAlign: TextAlign.start,),
                  AppTextMedium(title: "5. بيانات الاتصال بنا"),
                  AppTextRegular(title: "للمجموعة المالية فريق خدمة عملاء متخصص في موضوعات حماية البيانات. وتستطيع الوصول لهم في أي وقت عن طريق EFGHermes_DataProtection@efg-hermes.com . وهم يقومون بالتعامل مع كافة الأمور الخاصة بحماية البيانات التي تخص كافة شركات المجموعة المالية بما فيها شركة تنميه."),


                  SizedBox(height: 20.h,),

                  Center(child: AppTextBold(title: "حدثت أخر مرة في أغسطس 2023.")),
                  SizedBox(height: 20.h,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}