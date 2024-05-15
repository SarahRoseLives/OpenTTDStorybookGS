import sys
import re
import os
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QComboBox, QPushButton, QTextEdit, QHBoxLayout, QLineEdit


class MyApplication(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()
        self.text_edit.textChanged.connect(self.update_page_text)


    def initUI(self):
        self.setWindowTitle('OpenTTD StoryBook GameScript Generator')

        self.layout = QVBoxLayout()

        # Page selection section
        self.page_layout = QHBoxLayout()

        # Dropdown box for selecting pages
        self.page_combo_box = QComboBox()
        self.page_combo_box.addItems(['Page 1', 'Page 2', 'Page 3'])  # Example pages
        self.page_combo_box.currentIndexChanged.connect(self.update_page_text)
        self.page_combo_box.currentIndexChanged.connect(self.update_page_name_edit)
        self.page_layout.addWidget(self.page_combo_box)

        # New Page button
        self.new_page_button = QPushButton('New Page')
        self.new_page_button.clicked.connect(self.create_new_page)
        self.page_layout.addWidget(self.new_page_button)

        # Remove Page button
        self.remove_page_button = QPushButton('Remove Page')
        self.remove_page_button.clicked.connect(self.remove_page)
        self.page_layout.addWidget(self.remove_page_button)

        self.layout.addLayout(self.page_layout)

        # Page name editing
        self.page_name_edit = QLineEdit()
        self.page_name_edit.setPlaceholderText('Page Name')
        self.page_name_edit.textChanged.connect(self.update_combo_box)
        self.layout.addWidget(self.page_name_edit)

        # Layout for color buttons
        color_layout = QVBoxLayout()

        # Supported colors
        colors = ['Dark Blue', 'Pale Green', 'Pink', 'Yellow', 'Red', 'Light Blue',
                  'Green', 'Dark Green', 'Blue', 'Cream', 'Mauve', 'Purple',
                  'Orange', 'Brown', 'Grey', 'White']

        # Add color buttons
        row1 = QHBoxLayout()
        row2 = QHBoxLayout()
        for i, color in enumerate(colors):
            button = QPushButton(color)
            button.clicked.connect(lambda _, color=color: self.color_text(color))
            if i < len(colors) / 2:
                row1.addWidget(button)
            else:
                row2.addWidget(button)

        color_layout.addLayout(row1)
        color_layout.addLayout(row2)

        self.layout.addLayout(color_layout)

        # Text area for editing
        self.text_edit = QTextEdit()
        self.layout.addWidget(self.text_edit)

        # Save Button
        self.save_button = QPushButton('Save')
        self.save_button.clicked.connect(self.generate_backend_files)
        self.layout.addWidget(self.save_button)

        self.setLayout(self.layout)

        # Dictionary to store text content for each page
        self.page_texts = {page_name: '' for page_name in range(self.page_combo_box.count())}

    def create_new_page(self):
        new_page_number = len(self.page_texts) + 1
        new_page_name = f'Page {new_page_number}'
        self.page_combo_box.addItem(new_page_name)
        self.page_texts[new_page_name] = ''  # Initialize with empty text
        self.page_combo_box.setCurrentIndex(self.page_combo_box.count() - 1)

    def remove_page(self):
        current_index = self.page_combo_box.currentIndex()
        if current_index != -1:
            page_name = self.page_combo_box.currentText()
            del self.page_texts[page_name]
            self.page_combo_box.removeItem(current_index)

    def update_page_text(self):
        current_page = self.page_combo_box.currentText()
        page_text = self.text_edit.toPlainText()  # Get text from text edit widget
        self.page_texts[current_page] = page_text  # Update the page text in the dictionary

    def update_combo_box(self, text):
        index = self.page_combo_box.currentIndex()
        self.page_combo_box.setItemText(index, text)

        current_page = self.page_combo_box.currentText()
        self.page_texts[current_page] = text  # Update the page text in the dictionary

    def update_page_name_edit(self, index):
        current_page = self.page_combo_box.currentText()
        self.page_name_edit.setText(current_page)
        self.text_edit.setPlainText(self.page_texts[current_page])  # Update text edit with current page's text

    def color_text(self, color):
        cursor = self.text_edit.textCursor()
        selected_text = cursor.selectedText()

        if selected_text:
            cursor.beginEditBlock()
            cursor.insertText(f'{{{color.upper().replace(" ", "_")}}} {selected_text}')
            cursor.endEditBlock()
        else:
            current_text = self.page_name_edit.text()
            self.page_name_edit.setText(f'{{{color.upper().replace(" ", "_")}}} {current_text}')

    def generate_backend_files(self):
        if not os.path.exists('generated'):
            os.makedirs('generated')
        if not os.path.exists('generated/lang'):
            os.makedirs('generated/lang')

        main_nut_content = ''
        lang_content = ''

        # Generate main.nut content
        main_nut_content += '/** Import SuperLib for GameScript **/\n'
        main_nut_content += 'import("util.superlib", "SuperLib", 36);\n'
        main_nut_content += 'Story <- SuperLib.Story;\n\n'
        main_nut_content += 'class MainClass extends GSController {}\n\n'
        main_nut_content += 'function MainClass::Start()\n'
        main_nut_content += '{\n'
        main_nut_content += '    // Main Game Script loop\n'
        main_nut_content += '    while (true) {\n'
        main_nut_content += '        // Handle incoming messages from OpenTTD\n'
        main_nut_content += '        this.HandleEvents();\n'
        main_nut_content += '    }\n'
        main_nut_content += '}\n\n'
        main_nut_content += '/*\n'
        main_nut_content += ' * This method handles incoming events from OpenTTD.\n'
        main_nut_content += ' */\n'
        main_nut_content += 'function MainClass::HandleEvents()\n'
        main_nut_content += '{\n'
        main_nut_content += '    if(GSEventController.IsEventWaiting()) {\n'
        main_nut_content += '        local ev = GSEventController.GetNextEvent();\n'
        main_nut_content += '        if (ev == null) return;\n\n'
        main_nut_content += '        local ev_type = ev.GetEventType();\n'
        main_nut_content += '        switch (ev_type) {\n'
        main_nut_content += '            case GSEvent.ET_COMPANY_NEW: {\n'
        main_nut_content += '                local company_event = GSEventCompanyNew.Convert(ev);\n'
        main_nut_content += '                local company_id = company_event.GetCompanyID();\n'

        # Generate story pages
        for i in range(self.page_combo_box.count()):
            page_name = self.page_combo_box.itemText(i)
            page_text = self.page_texts.get(page_name, '')
            cleaned_page_name = re.sub(r"\{.*?\}", "", page_name)

            # Generate main.nut content for the current page
            main_nut_content += f'                // Create a new story page with your desired text\n'
            main_nut_content += f'                local {cleaned_page_name.upper().replace(" ", "_")} = Story.NewStoryPage(company_id, GSText(GSText.STR_{cleaned_page_name.upper().replace(" ", "_")}_TITLE),\n'

            lines = page_text.split('\n')
            for j in range(1, len(lines) + 1):  # Start enumeration from 1
                if lines[j - 1].strip():  # Check if line has text
                    main_nut_content += f'                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_{cleaned_page_name.upper().replace(" ", "_")}_LINE{j}),\n'
                else:  # If line has no text, include a placeholder
                    main_nut_content += f'                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_{cleaned_page_name.upper().replace(" ", "_")}_LINE{j}),\n'

            main_nut_content = main_nut_content.rstrip(',\n')  # Remove trailing comma and newline
            main_nut_content += '\n                );\n\n'

            # Generate language content for the current page
            lang_content += f'STR_{cleaned_page_name.upper().replace(" ", "_")}_TITLE    :{cleaned_page_name}\n'
            for j, line in enumerate(lines, start=1):
                lang_content += f'STR_{cleaned_page_name.upper().replace(" ", "_")}_LINE{j:<4}:{line}\n'
            lang_content += '\n'

        # Show the newly created story page
        main_nut_content += f'                GSStoryPage.Show({cleaned_page_name.upper().replace(" ", "_")});\n'
        main_nut_content += '                break;\n'
        main_nut_content += '            }\n'
        main_nut_content += '            // Handle other events if needed\n'
        main_nut_content += '        }\n'
        main_nut_content += '    }\n'
        main_nut_content += '}\n'

        # Write content to files
        with open('generated/main.nut', 'w') as main_file:
            main_file.write(main_nut_content)
        with open('generated/lang/english.txt', 'w') as lang_file:
            lang_file.write(lang_content)

        print("Files generated successfully.")  # Print outside the 'with' statements



if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MyApplication()
    window.show()
    sys.exit(app.exec_())
