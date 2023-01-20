class DemandesController < ApplicationController

    def index
        render json: Demande.all
      end

      def create
        @demande = Demande.new(post_params)
        nb_rdays = (@demande.end_date.to_date - @demande.start_date.to_date)+1
        
        @demande.update(:nb_rdays => nb_rdays ) 
        if(@demande.start_date> @demande.end_date)
          render json: "start date est superieur a end_date"
        elsif @demande.save
          render json: @demande 


        else
          render json: @demande.errors
        end

      end

      def show
        @demande = Demande.find(params[:id])
        render json: @demande
      end

      def update
        @demande = Demande.find(params[:id])
        @motif = Motif.where("id = ?" ,  @demande.motif_id ) 
        @user = User.where("id = ?" ,  @demande.employe_id ) 
       
    
        if post_params[:status] == 0 || post_params[:status] == 2
          @demande.update(post_params)
            render json: {
            demande:@demande,
            motif: @motif,
            user: @user}
        elsif post_params[:status] == 1
         
          demande_days = (@demande.nb_rdays).to_f
          balance_days = @user.pluck(:balance).join(',').to_f
          result = (balance_days-demande_days).to_f
          @demande.update(post_params) 
          @user.update_all(:balance => result)

          render json: {
            demande: @demande,
            motif: @motif,
            user: @user}
        else
          render json: @demande.errors, statut: :unprocessable_entity
        end
      end
      def statistique_employer
        @accepter=Demande.where(status:1).where(employe_id:"id = ?").count()
        @refuse=Demande.where(status:2).where(employe_id:"id = ?").count()
        @encours=Demande.where(status:0).where(employe_id:"id = ?").count()
        render json:{

        accepter:@accepter,
        refuse:@refuse,
        encours:@encours
        }
      end
      def statistique_admin
        @accepter=Demande.where(status:1).count()
        @refuse=Demande.where(status:2).count()
        @encours=Demande.where(status:0).count()
       render json:{
      
       accepter:@accepter,
       refuse:@refuse,
       encours:@encours
       }
      end
      def destroy
        @demande = Demande.find(params[:id])
        @demande.destroy
      end

      private
      def set_post
        @demande = Demande.find(params[:id])
      end
      private
      def post_params
        params.permit(:start_date, :end_date, :commentaire, :employe_id, :motif_id )
      end

    
  end

   