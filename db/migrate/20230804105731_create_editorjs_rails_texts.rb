class CreateEditorjsRailsTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :editorjs_rails_texts, id: :uuid do |t|
      t.string :name, null: false
      t.jsonb :content, default: {}
      t.references :record, null: false, polymorphic: true, index: false, type: :uuid

      t.timestamps
    end
  end
end
