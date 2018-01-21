ActiveAdmin.register Show do
  permit_params :status
  form do |f|
    f.inputs "Show Details" do
      f.input :status, :as => :select,  :collection => Show.statuses.keys
    end
    f.actions
  end

end
