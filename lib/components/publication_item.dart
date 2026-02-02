import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cv_model.dart';

class PublicationItem extends StatelessWidget {
  final Publication publication;

  const PublicationItem({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: publication.url.isNotEmpty ? () => launchUrl(Uri.parse(publication.url)) : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEDF2F7)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Publisher Logo
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              padding: const EdgeInsets.all(4),
              child: publication.publisherLogoUrl.isNotEmpty
                  ? FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: publication.publisherLogoUrl,
                      fit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.article, color: Colors.grey);
                      },
                    )
                  : const Icon(Icons.article, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    publication.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        publication.publisher,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (publication.date.isNotEmpty) ...[
                        Text(" • ", style: TextStyle(color: Colors.grey[500])),
                        Text(
                          publication.date,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ],
                  ),
                  if (publication.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      publication.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (publication.url.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.open_in_new, size: 14, color: Theme.of(context).primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          "Read Article",
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
