module ApiDoc
  module Games
    extend Dox::DSL::Syntax

    document :api do
      resource 'Games' do
        endpoint '/Games'
        group 'Games'
      end

      group 'Games' do
        desc 'Games group'
      end
    end

    document :index do
      action 'Get Games'
    end

    document :show do
      action 'Get a Game'
    end

    document :update do
      action 'Update a Game'
    end

    document :create do
      action 'Create a Game'
    end

    document :destroy do
      action 'Delete a Game'
    end
  end
end
