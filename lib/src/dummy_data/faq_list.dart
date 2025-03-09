// faq_data.dart


import '../model/profile/faq_model.dart';

class FAQData {
  static final List<FAQItem> faqItems = [
    FAQItem(
        question: 'How do I update the menu using the app?',
        answer:
            'To update the menu, go to the settings page, then click on Menu Options to make changes.'),
    FAQItem(
        question: 'Can I track table orders through the app?',
        answer:
            'Yes, the app allows you to track all table orders and their statuses.'),
    FAQItem(
        question: 'How do I track inventory using the app?',
        answer:
            'Go to the Inventory section in the dashboard to see all items available in stock.'),
    FAQItem(
        question: 'How do I create an account?',
        answer:
            'You can create an account by visiting the Sign-Up page and filling out your details.'),
    FAQItem(
        question: 'Can the app handle payment processing?',
        answer:
            'Yes, our app integrates with multiple payment processing services.'),
    FAQItem(
        question: 'How do I access sales reports?',
        answer:
            'Sales reports can be accessed by navigating to the Reports section in the main menu.'),
  ];
}
