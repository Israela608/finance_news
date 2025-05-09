import 'package:cached_network_image/cached_network_image.dart';
import 'package:finance_news/common/loading_stack.dart';
import 'package:finance_news/core/helper/navigation.dart';
import 'package:finance_news/core/utils/app_colors.dart';
import 'package:finance_news/core/utils/app_styles.dart';
import 'package:finance_news/core/utils/converters.dart';
import 'package:finance_news/core/utils/extensions.dart';
import 'package:finance_news/data/constants/strings.dart';
import 'package:finance_news/data/models/news.dart';
import 'package:finance_news/data/repos/user_repo.dart';
import 'package:finance_news/modules/providers/news_provider.dart';
import 'package:finance_news/modules/screens/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NewsScreen extends HookConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _firstName = useState<String?>(null);

    _getFirstName() async {
      _firstName.value = await UserRepo.getFirstName();
    }

    useEffect(() {
      _getFirstName();

      return null;
    }, []);

    return LoadingStack(
      loadingProvider: newsLoadingProvider,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(newsProvider.notifier).fetchNews();
        },
        child: Scaffold(
          backgroundColor: AppColor.black,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 22.h,
                    bottom: 22.h,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _firstName.value != null
                        ? '${Strings.greeting} ${_firstName.value}'
                        : '',
                    textScaler: TextScaler.noScaling,
                    style: AppStyle.titleStyleWhite(context),
                  ),
                ),
                Expanded(
                  child: Consumer(builder: (context, ref, child) {
                    final newsList = ref.watch(newsProvider).news;

                    return ListView.builder(
                      //controller: _controller,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: newsList.length,
                      itemBuilder: (context, index) => ListTile(
                        title: NewsTile(
                          firstName: _firstName.value ?? '',
                          news: newsList[index],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.firstName, required this.news});

  final String firstName;
  final News news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigation.gotoWidget(
          context,
          NewsDetailScreen(
            firstName: firstName,
            url: news.url ?? '',
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: news.image ?? '',
              placeholder: (context, url) => CustomLoader(size: 25),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
            /*Image.network(
              'src',
              height: 100.h,
              width: 100.w,
            ),*/
            16.width,
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        news.source?.toUpperCase() ?? '',
                        textScaler: TextScaler.noScaling,
                        style: AppStyle.bodyWhiteSmallStyle(context),
                      ),
                      Text(
                        formatUnixDate(news.datetime).toUpperCase(),
                        textScaler: TextScaler.noScaling,
                        style: AppStyle.bodyWhiteSmallStyle(context),
                      ),
                    ],
                  ),
                  8.height,
                  Text(
                    news.headline ?? '',
                    textScaler: TextScaler.noScaling,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.bodyWhiteSmallBig(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
