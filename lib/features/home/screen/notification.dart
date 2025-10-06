import 'package:flutter/material.dart';

import 'package:workspace/core/helper/navigation.dart';
import 'package:workspace/core/components/app_bar.dart';
import 'package:workspace/core/components/app_network_image.dart';
import 'package:workspace/features/home/model/notification_model.dart';
import 'package:workspace/features/home/screen/notification_detail.dart';
import 'package:workspace/features/home/service/notification_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final PagingController<int, NotificationModel> _pagingController =
      PagingController(firstPageKey: 0);
  final int perPage = 10;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await NotificationService().getNotificationList(
        page: pageKey,
        perPage: perPage,
      );
      final isLastPage = newItems.length < perPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
        onBackTap: () => Navigator.pop(context),
      ),
      body: PagedListView(
        padding: EdgeInsets.all(20),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<NotificationModel>(
          itemBuilder: (context, item, index) => NotificationItem(data: item),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.data});
  final NotificationModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap:
            () => AppNavigator.push(context, NotificationDetail(model: data)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: AppCachedImage(data.image),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? '',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      data.content ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Text(
                      data.createdAt ?? '',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
