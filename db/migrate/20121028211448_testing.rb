class Testing < ActiveRecord::Migration
  def self.up
    drop_table :test_files
    drop_table :test_results

    create_table :test_files do |t|
      t.string :file_name
      t.references :assignment
      t.text :description
    end

    add_index :test_files,
              ["assignment_id"],
              :name => "index_test_files_on_assignment_id"

    create_table :test_scripts do |t|
      t.integer "assignment_id"
      t.float   "seq_num"
      t.string  "script_name"
      t.text    "description"
      t.integer "max_marks"
      t.boolean "run_on_submission"
      t.boolean "run_on_request"
      t.boolean "uses_token"
      t.boolean "halts_testing"
      t.string "display_description"
      t.string "display_run_status"
      t.string "display_marks_earned"
      t.string "display_input"
      t.string "display_expected_output"
      t.string "display_actual_output"
    end

    add_index :test_scripts,
              ["assignment_id", "seq_num"],
              :name => "index_test_scripts_on_assignment_id_and_seq_num"


    create_table :test_results do |t|
      t.references :submission
      t.string "completion_status"
      t.integer "assignment_id"
      t.integer "test_script_id"
      t.integer "marks_earned"
      t.text    "input_description"
      t.text    "actual_output"
      t.text    "expected_output"
    end

    add_index :test_results,
              ["assignment_id", "test_script_id", "submission_id"],
              :name => "assignment_id_and_test_script_id_and_submission_id"
  end

  def self.down
    drop_table :test_scripts
    drop_table :test_results
    drop_table :test_files

    create_table "test_files", :force => true do |t|
      t.string   "filename"
      t.integer  "assignment_id"
      t.string   "filetype"
      t.boolean  "is_private"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

      add_index "test_files",
                ["assignment_id", "filename"],
                :name => "index_test_files_on_assignment_id_and_filename",
                :unique => true

      create_table "test_results", :force => true do |t|
        t.string   "filename"
        t.text     "file_content"
        t.integer  "submission_id"
        t.datetime "created_at"
        t.datetime "updated_at"
        t.string   "status"
        t.integer  "user_id"
      end

        add_index "test_results",
                  ["filename"],
                  :name => "index_test_results_on_filename"
        add_index "test_results",
                  ["submission_id"],
                  :name => "index_test_results_on_submission_id"
  end
end
