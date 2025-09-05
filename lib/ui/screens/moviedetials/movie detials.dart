import 'package:movies_app/core/utils/constants/imports.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔥 دي اللي هتخلي الكونتينر يبدا من ورا الاب بار
      appBar: AppBar(
        backgroundColor: Colors.transparent, // شفاف عشان يبان وراه
        elevation: 0, // يشيل الظل
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
        actions: const [
          Icon(Icons.bookmark, color: Colors.white),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.04),
              child: Container(
                width: double.infinity,
                height: height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.moviedetials),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.28),
                      child: Image.asset(AppAssets.video),
                    ),
                    SizedBox(height: height * 0.16),
                    Text(
                      'Doctor Strange in the Multiverse\nof Madness',
                      style: AppTextStyles.whiteBold20,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red, // لون الزر
                fixedSize: Size(width * 0.95, height * 0.077),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'watch',
                style: AppTextStyles.whiteBold24,
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: Container(
                    width: width * 0.28,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.darkGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.04),
                          child: Image.asset(AppAssets.love),
                        ),
                        Text(
                          '15',
                          style: AppTextStyles.whiteBold20,
                        ),
                        SizedBox(width: width * 0.01)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: Container(
                    width: width * 0.28,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.darkGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.04),
                          child: Image.asset(AppAssets.timer),
                        ),
                        Text(
                          '90',
                          style: AppTextStyles.whiteBold20,
                        ),
                        SizedBox(width: width * 0.01)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: Container(
                    width: width * 0.28,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.darkGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.04),
                          child: Image.asset(AppAssets.negma),
                        ),
                        Text(
                          '7.6',
                          style: AppTextStyles.whiteBold20,
                        ),
                        SizedBox(width: width * 0.01)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            // ===== Screen Shots =====
            Padding(
              padding: EdgeInsets.only(right: width * 0.5),
              child: Text(
                "Screen Shots",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              height: height * 0.45, // 👈 قللتها بدل 0.7
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        "assets/images/screen${index + 1}.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.015), // 👈 قللت المسافة

            // ===== Similar =====
            Padding(
              padding: EdgeInsets.only(right: width * 0.7),
              child: Text(
                "Similar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: height * 0.01), // 👈 قللت المسافة

            CustomGrideView(
              images: [
                AppAssets.similar1,
                AppAssets.similar2,
                AppAssets.similar3,
                AppAssets.similar4,
              ],
              ratingd: ["7.5", "8.0", "6.9", "7.2"],
              rowItemCount: 2,
            ),

            // ===== Summary =====
            Padding(
                padding: EdgeInsets.only(right: width * 0.7),
                child: Text(
                  "Summary",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 12),
            Text(
              "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse. —Blazer346",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 1.5, // المسافة بين السطور
              ),
              softWrap: true, // 👈 يخلي النص يكسر السطر تلقائي
              overflow: TextOverflow.visible, // يظهر كله بدون قص
            ),
            const SizedBox(height: 30),

            // ===== Cast =====
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Cast",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Container(
                          width: width * 0.7,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.darkGrey),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(AppAssets.char1),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Name : Hayley Atwell',
                                    style: AppTextStyles.whiteRegular16,
                                  ),
                                  Text(
                                    'Character : Captain Carter',
                                    style: AppTextStyles.whiteRegular16,
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(width: 16),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // ===== Genres =====
            const Text(
              "Genres",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // أول صف 3 Genres
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildGenreContainer("Action"),
                _buildGenreContainer("Sci-Fi"),
                _buildGenreContainer("Adventure"),
              ],
            ),
            const SizedBox(height: 12),
            // تاني صف 2 Genres
            Row(
              children: [
                _buildGenreContainer("Fantasy"),
                const SizedBox(width: 12),
                _buildGenreContainer("Horror"),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ===== ويدجيت أيكونات Like, Rate, Time =====
Widget _buildIconContainer(IconData icon, String label) {
  return Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    ),
  );
}

// ===== ويدجيت الكونتينر بتاع Genres =====
Widget _buildGenreContainer(String genre) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      genre,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    ),
  );
}

class CustomGrideView extends StatelessWidget {
  final List<String> images;
  final List<String> ratingd;
  final int rowItemCount;

  const CustomGrideView({
    super.key,
    required this.images,
    required this.ratingd,
    this.rowItemCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowItemCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 4 / 6,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // صورة الفيلم
              Image.asset(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              // التقييم فوق الصورة
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    ratingd[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}